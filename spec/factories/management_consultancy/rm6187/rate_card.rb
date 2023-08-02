FactoryBot.define do
  factory :management_consultancy_rm6187_rate_card, class: 'ManagementConsultancy::RM6187::RateCard' do
    supplier factory: %i[management_consultancy_rm6187_supplier]
    lot { 'MCF3.1' }
    contact_name { Faker::Name.unique.name }
    junior_rate_in_pence { 1000 }
    standard_rate_in_pence { 2000 }
    senior_rate_in_pence { 3000 }
    principal_rate_in_pence { 4000 }
    managing_rate_in_pence { 5000 }
    director_rate_in_pence { 6000 }
  end
end
