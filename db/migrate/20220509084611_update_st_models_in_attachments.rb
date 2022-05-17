class UpdateStModelsInAttachments < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/SkipsModelValidations
  def up
    RECORD_TYPE_CONVERSION.each do |old_record_type, new_record_type|
      ActiveStorage::Attachment.where(record_type: old_record_type).update_all(record_type: new_record_type)
    end
  end

  def down
    RECORD_TYPE_CONVERSION.each do |old_record_type, new_record_type|
      ActiveStorage::Attachment.where(record_type: new_record_type).update_all(record_type: old_record_type)
    end
  end
  # rubocop:enable Rails/SkipsModelValidations

  RECORD_TYPE_CONVERSION = {
    'SupplyTeachers::Admin::Upload' => 'SupplyTeachers::RM3826::Admin::Upload',
    'SupplyTeachers::Admin::CurrentData' => 'SupplyTeachers::RM3826::Admin::CurrentData'
  }.freeze
end
