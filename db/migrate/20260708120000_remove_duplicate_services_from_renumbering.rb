require 'csv'

class RemoveDuplicateServicesFromRenumbering < ActiveRecord::Migration[8.1]
  class Services < ApplicationRecord
    self.table_name = 'services'
  end

  class SupplierFrameworkLotServices < ApplicationRecord
    self.table_name = 'supplier_framework_lot_services'
  end

  SERVICES_FILE_PATH = Rails.root.join('data', 'services.csv')

  def up
    duplicate_groups.each_key do |lot_id, name|
      dedupe_group(lot_id, name)
    end
  end

  def down; end

  private

  def current_ids
    @current_ids ||= CSV.read(SERVICES_FILE_PATH, headers: true).to_set { |row| row['id'] }
  end

  def duplicate_groups
    Services.group(:lot_id, :name).having('count(services.id) > 1').count
  end

  def dedupe_group(lot_id, name)
    rows = Services.where(lot_id:, name:).to_a
    keepers, orphans = rows.partition { |row| current_ids.include?(row.id) }

    return unless keepers.size == 1

    keeper = keepers.first
    orphans.each { |orphan| remove_orphan(orphan, keeper) }
  end

  def remove_orphan(orphan, keeper)
    SupplierFrameworkLotServices.where(service_id: orphan.id).find_each do |join_row|
      repoint_or_remove_join_row(join_row, keeper)
    end

    orphan.destroy!
  end

  def repoint_or_remove_join_row(join_row, keeper)
    if SupplierFrameworkLotServices.exists?(supplier_framework_lot_id: join_row.supplier_framework_lot_id, service_id: keeper.id)
      join_row.destroy!
    else
      join_row.update!(service_id: keeper.id)
    end
  end
end
