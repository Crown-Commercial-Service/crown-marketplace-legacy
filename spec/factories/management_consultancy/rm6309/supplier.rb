FactoryBot.define do
  factory :management_consultancy_rm6309_supplier, class: 'ManagementConsultancy::RM6309::Supplier' do
    name { Faker::Name.unique.name }
    contact_name { Faker::Name.unique.name }
    contact_email { Faker::Internet.unique.email }
    telephone_number { Faker::PhoneNumber.unique.phone_number }

    after :create do |supplier|
      (1..9).each do |lot|
        create_list(:management_consultancy_rm6309_rate_card, 1, supplier: supplier, rate_type: 'Advice', lot: "MCF4.#{lot}")
        create_list(:management_consultancy_rm6309_rate_card, 1, supplier: supplier, rate_type: 'Delivery', lot: "MCF4.#{lot}")
        create_list(:management_consultancy_rm6309_lot_contact_detail, 1, supplier: supplier, contact_name: supplier.contact_name, lot: "MCF4.#{lot}")
      end
    end
  end
end
