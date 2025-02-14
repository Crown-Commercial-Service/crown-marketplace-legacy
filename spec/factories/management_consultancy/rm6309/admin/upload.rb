FactoryBot.define do
  factory :management_consultancy_rm6309_admin_upload, class: 'ManagementConsultancy::RM6309::Admin::Upload'

  factory :management_consultancy_rm6309_admin_upload_with_document, parent: :management_consultancy_rm6309_admin_upload do
    supplier_details_file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
