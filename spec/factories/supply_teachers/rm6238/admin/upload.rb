FactoryBot.define do
  factory :supply_teachers_rm6238_admin_upload, class: 'SupplyTeachers::RM6238::Admin::Upload'

  factory :supply_teachers_rm6238_admin_upload_with_document, parent: :supply_teachers_rm6238_admin_upload do
    current_accredited_suppliers { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
