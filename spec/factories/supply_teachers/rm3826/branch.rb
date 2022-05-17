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
  end
end
