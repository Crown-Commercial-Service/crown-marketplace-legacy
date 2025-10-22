FactoryBot.define do
  factory :legal_services_rm6240_admin_supplier_contact_detail, class: 'LegalServices::RM6240::Admin::SupplierContactDetail', parent: :supplier_framework_contact_detail do
    after(:build) do |supplier_framework_contact_detail|
      supplier_framework_contact_detail.supplier_framework ||= create(:supplier_framework, framework_id: 'RM6240')
    end
  end
end
