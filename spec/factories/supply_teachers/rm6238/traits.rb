FactoryBot.define do
  trait :supply_teachers_rm6238_direct_provision do
    lot_number { '1' }
  end

  trait :supply_teachers_rm6238_master_vendor do
    lot_number { '2' }
  end

  trait :supply_teachers_rm6238_master_vendor_below_threshold do
    lot_number { '2.1' }
  end

  trait :supply_teachers_rm6238_master_vendor_above_threshold do
    lot_number { '2.2' }
  end

  trait :supply_teachers_rm6238_education_technology_platforms do
    lot_number { '4' }
  end
end
