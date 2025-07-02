FactoryBot.define do
  factory :service, class: 'Service' do
    number { Faker::Number.number(digits: 2) }
    lot factory: %i[lot]
    name { Faker::Alphanumeric.alphanumeric(number: 10) }

    after(:build) do |service|
      service.id = "#{service.lot.id}.#{service.number}"
    end
  end
end
