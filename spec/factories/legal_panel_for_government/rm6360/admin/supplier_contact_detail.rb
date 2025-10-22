FactoryBot.define do
  factory :legal_panel_for_government_rm6360_admin_supplier_contact_detail, class: 'LegalPanelForGovernment::RM6360::Admin::SupplierContactDetail', parent: :supplier_framework_contact_detail do
    after(:build) do |supplier_framework_contact_detail|
      supplier_framework_contact_detail.supplier_framework ||= create(:supplier_framework, framework_id: 'RM6360')
    end
  end
end
