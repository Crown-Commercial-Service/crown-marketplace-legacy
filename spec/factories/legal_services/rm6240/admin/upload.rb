FactoryBot.define do
  factory :legal_services_rm6240_admin_upload, class: 'LegalServices::RM6240::Admin::Upload' do
  end

  factory :legal_services_rm6240_admin_upload_with_document, parent: :legal_services_rm6240_admin_upload do
    supplier_details_file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
