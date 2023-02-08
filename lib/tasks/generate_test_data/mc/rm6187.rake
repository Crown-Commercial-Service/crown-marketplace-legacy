module GenerateTestData
  module MC
    module RM6187
      def self.generate_data
        generate_suppliers
        generate_lot_data
        generate_rate_cards
        write_to_file
      end

      def self.generate_suppliers
        @suppliers = (0..9).map do
          supplier_name = Faker::Company.unique.name.upcase
          {
            id: SecureRandom.uuid,
            name: supplier_name,
            contact_email: Faker::Internet.email(name: supplier_name),
            telephone_number: Faker::PhoneNumber.phone_number,
            sme: rand < 0.5,
            address: Faker::Address.full_address,
            website: Faker::Internet.url,
            duns: Faker::Company.unique.duns_number.delete('-').to_s,
            lots: [],
            rate_cards: []
          }
        end
      end

      def self.generate_lot_data
        @suppliers[..2].each do |supplier|
          mcf3_lots_and_services.each do |lot_number, services|
            supplier[:lots] << {
              lot_number: lot_number,
              services: services
            }
          end
        end

        @suppliers[3..].each do |supplier|
          mcf3_lots_and_services.sample(4).each do |lot_number, services|
            supplier[:lots] << {
              lot_number: lot_number,
              services: services.sample((services.size * rand(5..10) / 10).to_i)
            }
          end
        end
      end

      def self.generate_rate_cards
        @suppliers.each do |supplier|
          supplier[:lots].each do |lot|
            min_rate = rand(200..1000)
            contact_name = Faker::Name.name

            supplier[:rate_cards] << {
              lot: lot[:lot_number],
              junior_rate_in_pence: min_rate,
              standard_rate_in_pence: min_rate + 200,
              senior_rate_in_pence: min_rate + 400,
              principal_rate_in_pence: min_rate + 600,
              managing_rate_in_pence: min_rate + 800,
              director_rate_in_pence: min_rate + 1000,
              contact_name: contact_name,
              email: Faker::Internet.email(name: contact_name),
              telephone_number: Faker::PhoneNumber.phone_number
            }
          end
        end
      end

      def self.write_to_file
        File.write('data/management_consultancy/rm6187/dummy_supplier_data.json', JSON.pretty_generate(@suppliers))
      end

      def self.mcf3_lots_and_services
        @mcf3_lots_and_services ||= ManagementConsultancy::RM6187::Lot.all.map { |lot| [lot.number, lot.services.map(&:code)] }
      end
    end
  end
end

namespace :generate_test_data do
  namespace :mc do
    desc 'Generate test data for  Management Consultancy RM6187'
    task rm6187: :environment do
      GenerateTestData::MC::RM6187.generate_data
    end
  end
end
