FactoryBot.define do
  factory :legal_services_rm6240_service_offering, class: 'LegalServices::RM6240::ServiceOffering' do
    supplier factory: %i[legal_services_rm6240_supplier]
  end

  factory :legal_services_rm6240_full_service_provision_service_offering, parent: :legal_services_rm6240_service_offering do
    service_code { '1.1' }
    jurisdiction { 'a' }
  end

  factory :legal_services_rm6240_general_service_provision_service_offering, parent: :legal_services_rm6240_service_offering do
    service_code { '2.1' }
    jurisdiction { 'b' }
  end

  factory :legal_services_rm6240_transport_rail_service_offering, parent: :legal_services_rm6240_service_offering do
    service_code { '3.1' }
  end
end
