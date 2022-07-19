FactoryBot.define do
  factory :supply_teachers_rm3826_branch, class: 'SupplyTeachers::RM3826::Branch' do
    association :supplier, factory: :supply_teachers_rm3826_supplier
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
        branch.supplier.rates << create(:supply_teachers_rm3826_rate, mark_up: 0.15)
        branch.supplier.rates << create(:supply_teachers_rm3826_rate, job_type: 'qt', term: 'one_week', mark_up: 0.25)
        branch.supplier.rates << create(:supply_teachers_rm3826_rate, job_type: 'fixed_term', mark_up: 0.35)
      end
    end

    trait :with_extra_rates do
      after(:create) do |branch|
        branch.supplier.rates << create(:supply_teachers_rm3826_rate, job_type: 'senior', term: 'one_week', mark_up: 0.45)
      end
    end
  end
end
