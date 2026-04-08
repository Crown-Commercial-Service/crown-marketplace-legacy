FactoryBot.define do
  factory :legal_panel_for_government_rm6360_admin_upload, class: 'LegalPanelForGovernment::RM6360::Admin::Upload' do
    user { association(:user) }
    framework_id { 'RM6360' }
  end

  factory :legal_panel_for_government_rm6360_admin_upload_with_document, parent: :legal_panel_for_government_rm6360_admin_upload do
    supplier_details_file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_xlsx.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end
end
