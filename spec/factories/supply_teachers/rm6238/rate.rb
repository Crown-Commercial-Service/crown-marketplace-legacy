FactoryBot.define do
  factory :supply_teachers_rm6238_rate, aliases: [:rm6238_direct_provision_rate], class: 'SupplyTeachers::RM6238::Rate' do
    association :supplier, factory: :supply_teachers_rm6238_supplier
    supply_teachers_rm6238_direct_provision
    job_type { 'nominated' }
    rate { 3000 }
  end

  factory :supply_teachers_rm6238_master_vendor_below_threshold_rate, parent: :supply_teachers_rm6238_rate do
    supply_teachers_rm6238_master_vendor_below_threshold
  end

  factory :supply_teachers_rm6238_master_vendor_above_threshold_rate, parent: :supply_teachers_rm6238_rate do
    supply_teachers_rm6238_master_vendor_above_threshold
  end

  factory :supply_teachers_rm6238_education_technology_platforms_rate, parent: :supply_teachers_rm6238_rate do
    supply_teachers_rm6238_education_technology_platforms
  end
end
