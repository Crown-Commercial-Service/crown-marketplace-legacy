FactoryBot.define do
  factory :management_consultancy_supplier, class: 'ManagementConsultancy::Supplier' do
    name { Faker::Name.unique.name }
    contact_name { Faker::Name.unique.name }
    contact_email { Faker::Internet.unique.email }
    telephone_number { Faker::PhoneNumber.unique.phone_number }

    after :create do |supplier|
      (1..9).each do |lot|
        create_list :management_consultancy_rate_card, 1, supplier: supplier, contact_name: supplier.contact_name, lot: "MCF3.#{lot}"
      end
    end
  end
end
