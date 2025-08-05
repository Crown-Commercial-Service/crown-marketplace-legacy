class AddChangesForLegalPanel < ActiveRecord::Migration[8.0]
  def change
    add_column :jurisdictions, :mapping_name, :text

    create_table :legal_panel_for_government_rm6360_admin_uploads, id: :uuid do |t|
      t.string :aasm_state, limit: 30
      t.text :import_errors

      t.timestamps
    end
  end
end
