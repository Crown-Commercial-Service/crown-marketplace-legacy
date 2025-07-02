FactoryBot.define do
  factory :supplier_framework_lot_branch, class: 'Supplier::Framework::Lot::Branch' do
    supplier_framework_lot factory: %i[supplier_framework_lot]

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
