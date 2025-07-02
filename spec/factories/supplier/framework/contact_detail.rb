FactoryBot.define do
  factory :supplier_framework_contact_detail, class: 'Supplier::Framework::ContactDetail' do
    supplier_framework factory: %i[supplier_framework]

    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    telephone_number { Faker::PhoneNumber.unique.phone_number }
    website { Faker::Internet.unique.url }
  end
end
