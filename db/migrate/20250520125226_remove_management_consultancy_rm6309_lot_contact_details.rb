class RemoveManagementConsultancyRM6309LotContactDetails < ActiveRecord::Migration[7.2]
  def change
    drop_table 'management_consultancy_rm6309_lot_contact_details', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'management_consultancy_rm6309_supplier_id'
      t.text 'lot'
      t.text 'contact_name'
      t.text 'telephone_number'
      t.text 'email'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['lot', 'management_consultancy_rm6309_supplier_id'], name: 'index_rm6309_lot_on_mc_supplier_id', unique: true
      t.index ['management_consultancy_rm6309_supplier_id'], name: 'index_mc_rm6309_lot_contact_details_on_supplier_id'
    end
  end
end
