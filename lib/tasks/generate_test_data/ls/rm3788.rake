module GenerateTestData
  module LS
    # rubocop:disable Metrics/ModuleLength
    module RM3788
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
            lot_4_prospectus_link: nil,
            rate_cards: [],
            lots: [],
            lot_1_services: []
          }
        end
      end

      def self.generate_lot_data
        generate_static_lot_1_data
        generate_random_lot_1_data
        generate_random_lot_2_data
        generate_static_lot_data
      end

      def self.generate_rate_cards
        @suppliers.each do |supplier|
          min_rate = rand(50..70)

          supplier[:rate_cards] << { lot: '1' }.merge(lot_rates(min_rate)) if supplier[:lot_1_services].any?

          supplier[:lots].each do |lot|
            supplier[:rate_cards] << { lot: lot[:lot_number] }.merge(lot_rates(min_rate, true))
          end
        end
      end

      def self.generate_static_lot_1_data
        @suppliers[..2].each do |supplier|
          %w[WPSLS.1.1 WPSLS.1.10].each do |service_code|
            (REGIONS + %w[UK]).each do |region_code|
              supplier[:lot_1_services] << {
                region_code: region_code,
                service_code: service_code
              }
            end
          end
        end

        @suppliers[3..5].each do |supplier|
          lot_services('1').each do |service_code|
            (REGIONS + %w[UK]).each do |region_code|
              supplier[:lot_1_services] << {
                region_code: region_code,
                service_code: service_code
              }
            end
          end
        end
      end

      def self.generate_random_lot_1_data
        @suppliers[6..8].each do |supplier|
          region_sample_size = (REGIONS.size * rand(5..9) / 10).to_i

          lot_services('1').sample(rand(6..12)).each do |service_code|
            REGIONS.sample(region_sample_size).each do |region_code|
              supplier[:lot_1_services] << {
                region_code: region_code,
                service_code: service_code
              }
            end
          end
        end
      end

      def self.generate_random_lot_2_data
        @suppliers[6..8].each do |supplier|
          sample_indexes = (0..34).to_a.sample(rand(15..30)).sort

          %w[a b c].each do |region|
            supplier[:lots] << {
              lot_number: "2#{region}",
              services: lot_services("2#{region}").select.with_index { |_, index| sample_indexes.include?(index) }
            }
          end
        end
      end

      def self.generate_static_lot_data
        STATIC_SUPPLIERS_OTHER_LOTS.each do |options|
          @suppliers[options[:supplier_range]].each do |supplier|
            options[:lot_numbers].each do |lot_number|
              supplier[:lots] << {
                lot_number: lot_number,
                services: lot_services(lot_number)
              }
            end
          end
        end
      end

      STATIC_SUPPLIERS_OTHER_LOTS = [
        { supplier_range: (3..5), lot_numbers: %w[2a 2b 2c] },
        { supplier_range: (9..10), lot_numbers: %w[2a] },
        { supplier_range: (11..12), lot_numbers: %w[2b] },
        { supplier_range: (13..14), lot_numbers: %w[2c] },
        { supplier_range: (..9), lot_numbers: %w[3] },
        { supplier_range: (5..), lot_numbers: %w[4] },
      ].freeze

      def self.lot_services(lot)
        case lot
        when '2a'
          @lot_2a_services ||= generate_codes_for_lot_2region('a')
        when '2b'
          @lot_2b_services ||= generate_codes_for_lot_2region('b')
        when '2c'
          @lot_2c_services ||= generate_codes_for_lot_2region('c')
        else
          LOT_TO_SERVICES[lot]
        end
      end

      def self.generate_codes_for_lot_2region(region)
        (1..35).map { |n| "WPSLS.2#{region}.#{n}" }
      end

      LOT_TO_SERVICES = {
        '1' => (1..14).map { |n| "WPSLS.1.#{n}" }.freeze,
        '3' => ['WPSLS.3.1'],
        '4' => ['WPSLS.4.1']
      }.freeze

      REGIONS = %w[UKC UKD UKE UKF UKG UKH UKI UKJ UKK UKL UKM UKN].freeze

      def self.lot_rates(min_rate, trainee = false)
        min_day_rate = min_rate / 6
        min_month_rate = min_rate * 20

        rates = {}

        if trainee
          rates[:trainee] = {
            hourly: min_day_rate * 500,
            daily: min_rate * 500,
            monthly: min_month_rate * 500
          }
        end

        rates.merge({
                      junior: {
                        hourly: min_day_rate * 1000,
                        daily: min_rate * 1000,
                        monthly: min_month_rate * 1000
                      },
                      solicitor: {
                        hourly: min_day_rate * 1500,
                        daily: min_rate * 1500,
                        monthly: min_month_rate * 1500
                      },
                      senior: {
                        hourly: min_day_rate * 1750,
                        daily: min_rate * 1750,
                        monthly: min_month_rate * 1750
                      },
                      managing: {
                        hourly: min_day_rate * 2000,
                        daily: min_rate * 2000,
                        monthly: min_month_rate * 2000
                      }
                    })
      end

      def self.write_to_file
        File.open('data/legal_services/rm3788/dummy_supplier_data.json', 'w') do |file|
          file.write(JSON.pretty_generate(@suppliers))
        end
      end
    end
    # rubocop:enable Metrics/ModuleLength
  end
end

namespace :generate_test_data do
  namespace :ls do
    desc 'Generate test data for  Management Consultancy'
    task rm3788: :environment do
      GenerateTestData::LS::RM3788.generate_data
    end
  end
end
