FactoryBot.define do
  factory :supplier_framework_lot_service, class: 'Supplier::Framework::Lot::Service' do
    supplier_framework_lot factory: %i[supplier_framework_lot]
    service factory: %i[service]
  end
end
