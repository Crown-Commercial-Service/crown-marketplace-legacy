class MoveUploadsToNewModel < ActiveRecord::Migration[8.1]
  class Users < ApplicationRecord
    self.table_name = 'users'
  end

  class Frameworks < ApplicationRecord
    self.table_name = 'frameworks'
  end

  class AdminUploads < ApplicationRecord
    self.table_name = 'admin_uploads'
  end

  class LPFGAdminUploads < ApplicationRecord
    self.table_name = 'legal_panel_for_government_rm6360_admin_uploads'
  end

  class LSAdminUploads < ApplicationRecord
    self.table_name = 'legal_services_rm6240_admin_uploads'
  end

  class MCRM6187AdminUploads < ApplicationRecord
    self.table_name = 'management_consultancy_rm6187_admin_uploads'
  end

  class MCRM6309AdminUploads < ApplicationRecord
    self.table_name = 'management_consultancy_rm6309_admin_uploads'
  end

  class STAdminUploads < ApplicationRecord
    self.table_name = 'supply_teachers_rm6238_admin_uploads'

    serialize :import_errors, type: Array, coder: YAML
  end

  def migrate_upload(user, admin_upload, framework_id, record_type_prefix, is_supply_teachers)
    import_errors = if is_supply_teachers
                      admin_upload.fail_reason.present? ? [{ fail_reason: admin_upload.fail_reason }] : []
                    else
                      admin_upload.import_errors
                    end

    new_admin_upload = AdminUploads.create!(
      user_id: user.id,
      framework_id: framework_id,
      aasm_state: admin_upload.aasm_state,
      import_errors: import_errors,
      created_at: admin_upload.created_at,
      updated_at: admin_upload.updated_at
    )

    # rubocop:disable Rails/SkipsModelValidations
    ActiveStorage::Attachment.where(record_id: admin_upload.id, record_type: "#{record_type_prefix}::#{framework_id}::Admin::Upload").update_all(record_id: new_admin_upload.id)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def up
    ActiveRecord::Base.transaction do
      user = Users.find_by(email: 'timothy.south@crowncommercial.gov.uk')

      [
        ['RM6360', LPFGAdminUploads, 'LegalPanelForGovernment', false],
        ['RM6240', LSAdminUploads, 'LegalServices', false],
        ['RM6187', MCRM6187AdminUploads, 'ManagementConsultancy', false],
        ['RM6309', MCRM6309AdminUploads, 'ManagementConsultancy', false],
        ['RM6238', STAdminUploads, 'SupplyTeachers', true],
      ].each do |framework_id, model, record_type_prefix, is_supply_teachers|
        Rails.logger.info("Migrating uploads for #{framework_id}")

        model.find_in_batches do |group|
          group.each do |admin_upload|
            migrate_upload(user, admin_upload, framework_id, record_type_prefix, is_supply_teachers)
          end
        end
      end
    end
  end

  def down; end
end
