class FixIssueWithLsUploadsAgain < ActiveRecord::Migration[6.1]
  class LsRM6240AdminUpload < ApplicationRecord
    self.table_name = 'legal_services_rm6240_admin_uploads'
  end

  def up
    ActiveStorage::Attachment.where(record_type: 'LegalServices::Admin::Upload').find_in_batches do |attachment_group|
      sleep(5)

      attachment_group.each do |attachment|
        new_record_type = ''

        if LsRM6240AdminUpload.find_by(id: attachment.record_id)
          new_record_type = 'LegalServices::RM6240::Admin::Upload'
        else
          Rails.logger.warn("Could not find LegalServices::Admin::Upload for #{attachment.record_id}")

          next
        end

        attachment.update(record_type: new_record_type)
      end
    end
  end

  def down; end
end
