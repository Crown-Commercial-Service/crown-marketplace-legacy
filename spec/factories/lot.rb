FactoryBot.define do
  factory :lot, class: 'Lot' do
    number { Faker::Number.number(digits: 2) }
    framework factory: %i[framework]
    name { Faker::Alphanumeric.alphanumeric(number: 10) }

    after(:build) do |lot|
      lot.id = "#{lot.framework.id}.#{lot.number}"
    end
  end
end
