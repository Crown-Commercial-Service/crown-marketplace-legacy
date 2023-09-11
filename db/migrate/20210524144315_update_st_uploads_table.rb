class UpdateStUploadsTable < ActiveRecord::Migration[6.0]
  class STAdminUpload < ApplicationRecord
    self.table_name = 'supply_teachers_admin_uploads'
  end

  class STCurrentData < ApplicationRecord
    self.table_name = 'supply_teachers_admin_current_data'
  end

  def up
    STCurrentData.reset_column_information
    STAdminUpload.reset_column_information

    STCurrentData.destroy_all
    STAdminUpload.destroy_all

    change_column :supply_teachers_admin_uploads, :aasm_state, :string, limit: 30

    add_column :supply_teachers_admin_current_data, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # rubocop:disable Rails/DangerousColumnNames
    change_table :supply_teachers_admin_current_data do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    # rubocop:enable Rails/DangerousColumnNames
    execute 'ALTER TABLE supply_teachers_admin_current_data ADD PRIMARY KEY (id);'
  end

  def down
    STCurrentData.reset_column_information
    STAdminUpload.reset_column_information

    STCurrentData.destroy_all
    STAdminUpload.destroy_all

    change_column :supply_teachers_admin_uploads, :aasm_state, :string, limit: 15

    add_column :supply_teachers_admin_current_data, :uuid, :bigint

    # rubocop:disable Rails/DangerousColumnNames
    change_table :supply_teachers_admin_current_data do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    # rubocop:enable Rails/DangerousColumnNames
    execute 'ALTER TABLE supply_teachers_admin_current_data ADD PRIMARY KEY (id);'
  end
end
