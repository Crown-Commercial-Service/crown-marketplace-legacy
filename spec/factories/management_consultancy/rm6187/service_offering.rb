FactoryBot.define do
  factory :management_consultancy_rm6187_service_offering, class: 'ManagementConsultancy::RM6187::ServiceOffering' do
    supplier factory: %i[management_consultancy_rm6187_supplier]
    lot_number { 'MCF3.2' }
    service_code { 'MCF3.2.1' }
  end
end
