FactoryBot.define do
  factory :supply_teachers_rm6238_supplier, class: 'SupplyTeachers::RM6238::Supplier' do
    name { Faker::Name.unique.name }
  end
end
