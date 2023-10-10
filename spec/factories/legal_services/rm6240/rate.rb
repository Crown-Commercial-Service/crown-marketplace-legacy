FactoryBot.define do
  factory :legal_services_rm6240_rate, class: 'LegalServices::RM6240::Rate' do
    supplier factory: %i[legal_services_rm6240_supplier]
    rate { 3000 }
    position { '1' }
  end

  factory :legal_services_rm6240_full_service_provision_rate, parent: :legal_services_rm6240_rate do
    lot_number { '1' }
    jurisdiction { 'a' }
  end

  factory :legal_services_rm6240_general_service_provision_rate, parent: :legal_services_rm6240_rate do
    lot_number { '2' }
    jurisdiction { 'b' }
  end

  factory :legal_services_rm6240_transport_rail_rate, parent: :legal_services_rm6240_rate do
    lot_number { '3' }
  end
end
