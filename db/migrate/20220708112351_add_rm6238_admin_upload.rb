class AddRM6238AdminUpload < ActiveRecord::Migration[6.0]
  def change
    create_table :supply_teachers_rm6238_admin_uploads, id: :uuid do |t|
      t.string :aasm_state, limit: 30
      t.text :fail_reason

      t.timestamps
    end

    create_table :supply_teachers_rm6238_admin_current_data, id: :uuid do |t|
      t.text :error

      t.timestamps
    end
  end
end
