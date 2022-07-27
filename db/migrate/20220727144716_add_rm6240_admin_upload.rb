class AddRM6240AdminUpload < ActiveRecord::Migration[6.0]
  def change
    create_table :legal_services_rm6240_admin_uploads, id: :uuid do |t|
      t.string :aasm_state, limit: 30
      t.text :import_errors

      t.timestamps
    end
  end
end
