module GenerateTestData
  module LS
    # rubocop:disable Metrics/ModuleLength
    module RM6240
      def self.generate_data
        generate_suppliers
        generate_lot_data
        generate_rate_cards
        write_to_file
      end

      def self.generate_suppliers
        @suppliers = (0..14).map do
          supplier_name = Faker::Company.unique.name.upcase
          {
            supplier_id: SecureRandom.uuid,
            name: supplier_name,
            email: Faker::Internet.email(name: supplier_name),
            phone_number: Faker::PhoneNumber.phone_number,
            sme: rand < 0.5,
            address: Faker::Address.full_address,
            website: Faker::Internet.url,
            duns: Faker::Company.unique.duns_number.delete('-').to_s,
            lot_1_prospectus_link: nil,
            lot_2_prospectus_link: nil,
            lot_3_prospectus_link: nil,
            service_offerings: [],
            rates: []
          }
        end
      end

      def self.generate_lot_data
        generate_static_lot_data(..2, '1')
        generate_static_lot_data(2..4, '2')
        generate_random_lot_data(5..7, '1')
        generate_random_lot_data(9..10, '2')
        generate_static_lot_3_data
      end

      def self.generate_rate_cards
        generate_rates(..2, '1')
        generate_rates(2..4, '2')
        generate_rates(5..7, '1')
        generate_rates(9..10, '2')
        generate_lot_3_rates
      end

      def self.generate_static_lot_data(supplier_range, lot_number)
        @suppliers[supplier_range].each.with_index do |supplier, index|
          SERVICE_CODES[lot_number].each do |service_code|
            JURISDICTIONS.rotate(index)[..1].each do |jurisdiction|
              supplier[:service_offerings] << {
                service_code: "#{lot_number}.#{service_code}",
                jurisdiction: jurisdiction
              }
            end
          end
        end
      end

      def self.generate_random_lot_data(supplier_range, lot_number)
        @suppliers[supplier_range].each.with_index do |supplier, index|
          sample_services = SERVICE_CODES[lot_number].sample(rand(5..(SERVICE_CODES[lot_number].length - 5))).sort

          sample_services.each do |service_code|
            JURISDICTIONS.rotate(index)[..1].each do |jurisdiction|
              supplier[:service_offerings] << {
                service_code: "#{lot_number}.#{service_code}",
                jurisdiction: jurisdiction
              }
            end
          end
        end
      end

      def self.generate_static_lot_3_data
        @suppliers[7..].each do |supplier|
          supplier[:service_offerings] << {
            service_code: '3.1'
          }
        end
      end

      SERVICE_CODES = {
        '1' => (1..40).map(&:to_s),
        '2' => (1..15).map(&:to_s),
        '3' => '1'
      }.freeze

      JURISDICTIONS = %w[a b c].freeze

      def self.generate_rates(supplier_range, lot_number)
        @suppliers[supplier_range].each.with_index do |supplier, index|
          JURISDICTIONS.rotate(index)[..1].each do |jurisdiction|
            min_rate = rand(5..7) * 1000

            ('1'..'7').each do |position|
              supplier[:rates] << {
                lot_number: lot_number,
                jurisdiction: jurisdiction,
                position: position,
                rate: position_rate(min_rate, position)
              }
            end
          end
        end
      end

      def self.generate_lot_3_rates
        @suppliers[7..].each do |supplier|
          min_rate = rand(5..7) * 1000

          ('1'..'7').each do |position|
            supplier[:rates] << {
              lot_number: '3',
              position: position,
              rate: position_rate(min_rate, position)
            }
          end
        end
      end

      def self.position_rate(min_rate, position)
        return 0 if position == '7' && rand > 0.75

        (min_rate * POSITION_FACTOR[position]).to_i
      end

      POSITION_FACTOR = {
        '1' => 3.5,
        '2' => 3,
        '3' => 2.5,
        '4' => 2,
        '5' => 1.5,
        '6' => 1,
        '7' => 2.75
      }.freeze

      def self.write_to_file
        File.write('data/legal_services/rm6240/dummy_supplier_data.json', JSON.pretty_generate(@suppliers))
      end
    end
    # rubocop:enable Metrics/ModuleLength
  end
end

namespace :generate_test_data do
  namespace :ls do
    desc 'Generate test data for Legal Services RM6240'
    task rm6240: :environment do
      GenerateTestData::LS::RM6240.generate_data
    end
  end
end
