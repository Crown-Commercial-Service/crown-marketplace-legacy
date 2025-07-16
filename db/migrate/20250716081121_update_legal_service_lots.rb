class UpdateLegalServiceLots < ActiveRecord::Migration[8.0]
  def up
    ActiveRecord::Base.connection.truncate_tables(
      :frameworks,
      :lots,
      :services,
      :jurisdictions,
      :positions,
      :uploads,
      :supplier_frameworks,
      :supplier_framework_lots,
      :supplier_framework_contact_details,
      :supplier_framework_addresses,
      :supplier_framework_lot_services,
      :supplier_framework_lot_rates,
      :supplier_framework_lot_branches,
    )

    Rake::Task['db:update_frameworks'].invoke
  end

  def down; end
end
