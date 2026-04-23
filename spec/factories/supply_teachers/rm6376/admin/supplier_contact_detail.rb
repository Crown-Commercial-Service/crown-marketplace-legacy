FactoryBot.define do
  factory :supply_teachers_rm6376_admin_supplier_contact_detail, class: 'SupplyTeachers::RM6376::Admin::SupplierContactDetail', parent: :supplier_framework_contact_detail do
    after(:build) do |supplier_framework_contact_detail|
      supplier_framework_contact_detail.supplier_framework ||= create(:supplier_framework, framework_id: 'RM6376')
    end
  end
end
