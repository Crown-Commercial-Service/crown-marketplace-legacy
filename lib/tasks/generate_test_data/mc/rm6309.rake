module GenerateTestData
  module MC
    module RM6309
      def self.generate_data
        generate_suppliers
        generate_lot_data
        generate_rate_cards
        generate_lot_contact_details
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
            rate_cards: [],
            lot_contact_details: []
          }
        end
      end

      def self.generate_lot_data
        @suppliers[..2].each do |supplier|
          mcf4_lots_and_services.each do |lot_number, services|
            supplier[:lots] << {
              lot_number:,
              services:
            }
          end
        end

        @suppliers[3..].each do |supplier|
          mcf4_lots_and_services.sample(4).each do |lot_number, services|
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
            rate_types = ['Advice', 'Delivery']

            rate_types = ['Complex', 'Non-Complex'] if lot[:lot_number] == 'MCF4.10'

            rate_types.each do |rate_type|
              min_rate = rand(200..1000)

              supplier[:rate_cards] << {
                lot: lot[:lot_number],
                rate_type: rate_type,
                junior_rate_in_pence: min_rate,
                standard_rate_in_pence: min_rate + 200,
                senior_rate_in_pence: min_rate + 400,
                principal_rate_in_pence: min_rate + 600,
                managing_rate_in_pence: min_rate + 800,
                director_rate_in_pence: min_rate + 1000,
              }
            end
          end
        end
      end

      def self.generate_lot_contact_details
        @suppliers.each do |supplier|
          supplier[:lots].each do |lot|
            contact_name = Faker::Name.name

            supplier[:lot_contact_details] << {
              lot: lot[:lot_number],
              contact_name: contact_name,
              email: Faker::Internet.email(name: contact_name),
              telephone_number: Faker::PhoneNumber.phone_number
            }
          end
        end
      end

      def self.write_to_file
        File.write('data/management_consultancy/rm6309/dummy_supplier_data.json', JSON.pretty_generate(@suppliers))
      end

      def self.mcf4_lots_and_services
        @mcf4_lots_and_services ||= ManagementConsultancy::RM6309::Lot.all.map { |lot| [lot.number, lot.services.map(&:code)] }
      end
    end
  end
end

namespace :generate_test_data do
  namespace :mc do
    desc 'Generate test data for  Management Consultancy RM6309'
    task rm6309: :environment do
      GenerateTestData::MC::RM6309.generate_data
    end
  end
end
