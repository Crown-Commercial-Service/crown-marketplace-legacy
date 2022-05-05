FactoryBot.define do
  factory :legal_services_rm3788_regional_availability, class: 'LegalServices::RM3788::RegionalAvailability' do
    association :supplier, factory: :legal_services_rm3788_supplier
    region_code { 'UKC' }
    service_code { 'WPSLS.1.1' }
  end
end
