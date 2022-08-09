FactoryBot.define do
  factory :legal_services_rm6240_supplier, class: 'LegalServices::RM6240::Supplier' do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    phone_number { Faker::PhoneNumber.unique.phone_number }
  end
end
