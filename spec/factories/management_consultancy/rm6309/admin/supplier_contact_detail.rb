FactoryBot.define do
  factory :management_consultancy_rm6309_admin_supplier_contact_detail, class: 'ManagementConsultancy::RM6309::Admin::SupplierContactDetail', parent: :supplier_framework_contact_detail do
    after(:build) do |supplier_framework_contact_detail|
      supplier_framework_contact_detail.supplier_framework ||= create(:supplier_framework, framework_id: 'RM6309')
    end
  end
end
