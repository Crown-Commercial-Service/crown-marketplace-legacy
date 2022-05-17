FactoryBot.define do
  factory :legal_services_rm3788_service_offering, class: 'LegalServices::RM3788::ServiceOffering' do
    association :supplier, factory: :legal_services_rm3788_supplier
    lot_number { '1' }
    service_code { 'WPSLS.1.1' }
  end
end
