FactoryBot.define do
  factory :supplier_framework_lot_jurisdiction, class: 'Supplier::Framework::Lot::Jurisdiction' do
    supplier_framework_lot factory: %i[supplier_framework_lot]
    jurisdiction factory: %i[jurisdiction]
  end
end
