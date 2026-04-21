FactoryBot.define do
  factory :supply_teachers_rm6376_admin_upload, class: 'SupplyTeachers::RM6376::Admin::Upload' do
    user { association(:user) }
    framework_id { 'RM6376' }
  end

  factory :supply_teachers_rm6376_admin_upload_with_document, parent: :supply_teachers_rm6376_admin_upload do
    supplier_details_file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
