FactoryBot.define do
  factory :management_consultancy_rm6187_regional_availability, class: 'ManagementConsultancy::RM6187::RegionalAvailability' do
    supplier factory: %i[management_consultancy_rm6187_supplier]
    lot_number { 'MCF3.1' }
    region_code { 'UKC1' }
    expenses_required { false }
  end
end
