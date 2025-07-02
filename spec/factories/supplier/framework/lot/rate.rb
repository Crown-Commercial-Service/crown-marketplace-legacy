FactoryBot.define do
  factory :supplier_framework_lot_rate, class: 'Supplier::Framework::Lot::Rate' do
    supplier_framework_lot factory: %i[supplier_framework_lot]
    position factory: %i[position]
    rate { Faker::Number.within(range: 10000..100000000) }
  end
end
