Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'gov_uk_helper' => 'GovUKHelper',
    'fta_calculator_contract_end' => 'FTACalculatorContractEnd',
    'fta_calculator_contract_start' => 'FTACalculatorContractStart',
    'fta_calculator_salary' => 'FTACalculatorSalary',
    'fta_to_perm_contract_end' => 'FTAToPermContractEnd',
    'fta_to_perm_contract_start' => 'FTAToPermContractStart',
    'fta_to_perm_fee' => 'FTAToPermFee',
    'fta_to_perm_fixed_term_fee' => 'FTAToPermFixedTermFee',
    'fta_to_perm_hire_date_notice' => 'FTAToPermHireDateNotice',
    'fta_to_perm_hire_date' => 'FTAToPermHireDate',
    'fta_to_perm_calculator' => 'FTAToPermCalculator'
  )
end
