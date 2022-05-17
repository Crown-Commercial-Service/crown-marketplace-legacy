FactoryBot.define do
  factory :supply_teachers_rm3826_supplier, class: 'SupplyTeachers::RM3826::Supplier' do
    name { Faker::Name.unique.name }
  end
end
