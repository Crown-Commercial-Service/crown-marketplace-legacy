FactoryBot.define do
  factory :supply_teachers_rm6238_branch, class: 'SupplyTeachers::RM6238::Branch' do
    association :supplier, factory: :supply_teachers_rm6238_supplier
    postcode { Faker::Address.unique.postcode }
    location do
      Geocoding.point(
        latitude: Faker::Address.unique.latitude,
        longitude: Faker::Address.unique.longitude
      )
    end
    telephone_number { Faker::PhoneNumber.unique.phone_number }
    contact_name { Faker::Name.unique.name }
    contact_email { Faker::Internet.unique.email }
    name { Faker::Name.unique.name }

    trait :with_rates do
      after(:create) do |branch|
        branch.supplier.rates << create(:supply_teachers_rm6238_rate, rate: 1050)
        branch.supplier.rates << create(:supply_teachers_rm6238_rate, job_type: 'teacher', term: 'daily', rate: 2050)
        branch.supplier.rates << create(:supply_teachers_rm6238_rate, job_type: 'fixed_term', rate: 3050)
      end
    end

    trait :with_extra_rates do
      after(:create) do |branch|
        branch.supplier.rates << create(:supply_teachers_rm6238_rate, job_type: 'senior', term: 'daily', rate: 4050)
      end
    end
  end
end
