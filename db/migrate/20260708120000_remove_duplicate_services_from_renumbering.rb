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
    current_ids = CSV.read(SERVICES_FILE_PATH, headers: true).map { |row| row['id'] }.to_set

    duplicate_groups = Services.group(:lot_id, :name).having('count(services.id) > 1').count

    duplicate_groups.each_key do |lot_id, name|
      rows = Services.where(lot_id: lot_id, name: name).to_a
      keepers, orphans = rows.partition { |row| current_ids.include?(row.id) }

      next unless keepers.size == 1

      keeper = keepers.first

      orphans.each do |orphan|
        SupplierFrameworkLotServices.where(service_id: orphan.id).find_each do |join_row|
          if SupplierFrameworkLotServices.exists?(supplier_framework_lot_id: join_row.supplier_framework_lot_id, service_id: keeper.id)
            join_row.destroy!
          else
            join_row.update!(service_id: keeper.id)
          end
        end

        orphan.destroy!
      end
    end
  end

  def down; end
end
