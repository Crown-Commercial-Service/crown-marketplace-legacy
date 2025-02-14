FactoryBot.define do
  factory :management_consultancy_rm6309_lot_contact_detail, class: 'ManagementConsultancy::RM6309::LotContactDetail' do
    supplier factory: %i[management_consultancy_rm6309_supplier]
    lot { 'MCF4.1' }
    contact_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    telephone_number { Faker::PhoneNumber.unique.phone_number }
  end
end
