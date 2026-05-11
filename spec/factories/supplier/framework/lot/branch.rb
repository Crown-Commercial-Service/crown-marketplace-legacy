FactoryBot.define do
  factory :supplier_framework_lot_branch, class: 'Supplier::Framework::Lot::Branch' do
    postcode { Faker::Address.unique.postcode }
    location do
      Geocoding.point(
        latitude: Faker::Address.unique.latitude,
        longitude: Faker::Address.unique.longitude
      )
    end
    telephone_number { '07700 900000' }
    contact_name { Faker::Name.unique.name }
    contact_email { Faker::Internet.unique.email }
    name { Faker::Name.unique.name }
    region { Faker::Address.state }
    address_line_1 { Faker::Address.street_address }
    town { Faker::Address.city }

    after(:build) do |supplier_framework_lot_branch, evaluator|
      supplier_framework_lot_branch.supplier_framework_lot ||= evaluator.supplier_framework_lot || create(:supplier_framework_lot)
    end
  end
end
