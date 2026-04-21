class AddAdditionalDetailsToSupplier < ActiveRecord::Migration[8.1]
  def change
    change_table :suppliers, bulk: true do |t|
      t.jsonb :additional_details
    end

    add_index :suppliers, "(additional_details->'trading_name')", unique: true, name: 'index_suppliers_on_additional_details_trading_name'
    add_index :suppliers, "(additional_details->'additional_identifier')", unique: true, name: 'index_suppliers_on_additional_details_additional_identifier'
  end
end
