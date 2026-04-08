FactoryBot.define do
  factory :management_consultancy_rm6309_admin_upload, class: 'ManagementConsultancy::RM6309::Admin::Upload' do
    user { association(:user) }
    framework_id { 'RM6309' }
  end

  factory :management_consultancy_rm6309_admin_upload_with_document, parent: :management_consultancy_rm6309_admin_upload do
    supplier_details_file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
