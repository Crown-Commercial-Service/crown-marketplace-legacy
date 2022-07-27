FactoryBot.define do
  factory :supply_teachers_rm6238_managed_service_provider, class: 'SupplyTeachers::RM6238::ManagedServiceProvider' do
    association :supplier, factory: :supply_teachers_rm6238_supplier
    contact_name { Faker::Name.name }
    telephone_number { Faker::PhoneNumber.phone_number }
    contact_email { Faker::Internet.email }
  end

  factory :supply_teachers_rm6238_managed_service_provider_master_vendor, parent: :supply_teachers_rm6238_managed_service_provider do
    supply_teachers_rm6238_master_vendor
  end

  factory :supply_teachers_rm6238_managed_service_provider_education_technology_platforms, parent: :supply_teachers_rm6238_managed_service_provider do
    supply_teachers_rm6238_education_technology_platforms
  end
end
