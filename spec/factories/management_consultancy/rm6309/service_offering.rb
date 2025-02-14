FactoryBot.define do
  factory :management_consultancy_rm6309_service_offering, class: 'ManagementConsultancy::RM6309::ServiceOffering' do
    supplier factory: %i[management_consultancy_rm6309_supplier]
    lot_number { 'MCF4.2' }
    service_code { 'MCF4.2.1' }
  end
end
