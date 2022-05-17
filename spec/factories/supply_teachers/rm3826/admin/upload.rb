FactoryBot.define do
  factory :supply_teachers_rm3826_admin_upload, class: 'SupplyTeachers::RM3826::Admin::Upload' do
  end

  factory :supply_teachers_rm3826_admin_upload_with_document, parent: :supply_teachers_rm3826_admin_upload do
    current_accredited_suppliers { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
