FactoryBot.define do
  factory :supplier_framework_address, class: 'Supplier::Framework::Address' do
    supplier_framework factory: %i[supplier_framework]

    address_line_1 { Faker::Address.unique.street_name }
    address_line_2 { Faker::Address.unique.secondary_address }
    town { Faker::Address.unique.city }
    county { Faker::Address.unique.county }
    postcode { Faker::Address.unique.postcode }
  end
end
