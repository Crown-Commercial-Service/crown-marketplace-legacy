FactoryBot.define do
  factory :supplier_framework_lot, class: 'Supplier::Framework::Lot' do
    supplier_framework factory: %i[supplier_framework]
    lot factory: %i[lot]
    enabled { true }

    trait :with_rates do
      after(:create) do |supplier_framework_lot|
        create(:supplier_framework_lot_rate, position_id: 39, rate: 1050, supplier_framework_lot: supplier_framework_lot)
        create(:supplier_framework_lot_rate, position_id: 41, rate: 2050, supplier_framework_lot: supplier_framework_lot)
        create(:supplier_framework_lot_rate, position_id: 40, rate: 3050, supplier_framework_lot: supplier_framework_lot)
      end
    end

    trait :with_extra_rates do
      after(:create) do |supplier_framework_lot|
        create(:supplier_framework_lot_rate, position_id: 43, rate: 4050, supplier_framework_lot: supplier_framework_lot)
      end
    end
  end
end
