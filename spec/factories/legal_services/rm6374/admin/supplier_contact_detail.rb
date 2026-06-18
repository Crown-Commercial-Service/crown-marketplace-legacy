FactoryBot.define do
  factory :legal_services_rm6374_admin_supplier_contact_detail, class: 'LegalServices::RM6374::Admin::SupplierContactDetail', parent: :supplier_framework_contact_detail do
    after(:build) do |supplier_framework_contact_detail|
      supplier_framework_contact_detail.supplier_framework ||= create(:supplier_framework, framework_id: 'RM6374')
    end
  end
end
