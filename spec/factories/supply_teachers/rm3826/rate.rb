FactoryBot.define do
  trait :supply_teachers_rm3826_direct_provision do
    lot_number { 1 }
  end

  trait :supply_teachers_rm3826_master_vendor do
    lot_number { 2 }
  end

  trait :supply_teachers_rm3826_neutral_vendor do
    lot_number { 3 }
  end

  factory :supply_teachers_rm3826_rate, aliases: [:direct_provision_rate], class: 'SupplyTeachers::RM3826::Rate' do
    association :supplier, factory: :supply_teachers_rm3826_supplier
    supply_teachers_rm3826_direct_provision
    job_type { 'nominated' }
    mark_up { 0.5 }
  end

  factory :supply_teachers_rm3826_master_vendor_rate, parent: :supply_teachers_rm3826_rate do
    supply_teachers_rm3826_master_vendor
  end

  factory :supply_teachers_rm3826_neutral_vendor_rate, parent: :supply_teachers_rm3826_rate do
    supply_teachers_rm3826_neutral_vendor
  end
end
