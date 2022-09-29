class FixIssueWithLsUploads < ActiveRecord::Migration[6.0]
  def up
    ActiveStorage::Attachment.where(record_type: 'LegalServices::Admin::Upload').find_in_batches do |attachment_group|
      sleep(5)

      attachment_group.each do |attachment|
        new_record_type = ''

        if LegalServices::RM3788::Admin::Upload.find_by(id: attachment.record_id)
          new_record_type = 'LegalServices::RM3788::Admin::Upload'
        elsif LegalServices::RM6240::Admin::Upload.find_by(id: attachment.record_id)
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
