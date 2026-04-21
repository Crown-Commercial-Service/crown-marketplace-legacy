FactoryBot.define do
  factory :supplier, class: 'Supplier' do
    name { Faker::Name.unique.name }
    duns_number { Faker::Company.unique.duns_number.gsub('-', '') }
    sme { rand > 0.5 }

    trait :with_additional_details do
      additional_details { { trading_name: Faker::Name.unique.name, additional_identifier: SecureRandom.uuid } }
    end

    trait :with_supplier_frameworks do
      supplier_frameworks { create_list(:supplier_framework, 2) }
    end
  end
end
