FactoryBot.define do
  factory :supplier_framework_lot, class: 'Supplier::Framework::Lot' do
    supplier_framework factory: %i[supplier_framework]
    lot factory: %i[lot]
    jurisdiction factory: %i[jurisdiction]
    enabled { true }
  end
end
