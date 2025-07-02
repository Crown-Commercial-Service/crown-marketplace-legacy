FactoryBot.define do
  factory :supplier_framework, class: 'Supplier::Framework' do
    supplier factory: %i[supplier]
    framework factory: %i[framework]
    enabled { true }
  end
end
