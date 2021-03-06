FactoryBot.define do
  factory :legal_services_regional_availability, class: LegalServices::RegionalAvailability do
    association :supplier, factory: :legal_services_supplier
    region_code { 'UKC' }
    service_code { 'WPSLS.1.1' }
  end
end
