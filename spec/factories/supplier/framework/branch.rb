FactoryBot.define do
  factory :supplier_framework_branch, class: 'Supplier::Framework::Branch' do
    supplier_framework factory: %i[supplier_framework]

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
