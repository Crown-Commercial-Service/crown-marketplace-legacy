class AddGenericAdminUploadsModel < ActiveRecord::Migration[8.1]
  def change
    create_table :admin_uploads, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true, null: false
      t.references :framework, type: :text, foreign_key: true, index: true, null: false

      t.string :aasm_state, limit: 30
      t.text :import_errors

      t.timestamps
    end
  end
end
