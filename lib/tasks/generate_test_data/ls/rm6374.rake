module GenerateTestData
  module LS
    # rubocop:disable Metrics/ModuleLength
    module RM6374
      def self.generate_data
        generate_suppliers
        generate_lot_data
        generate_rate_cards
        write_to_file
      end

      def self.generate_suppliers
        @suppliers = (0..40).map do
          supplier_name = Faker::Company.unique.name.upcase
          domain = Faker::Internet.domain_name(domain: supplier_name)

          {
            id: SecureRandom.uuid,
            name: supplier_name,
            duns_number: Faker::Company.unique.duns_number.delete('-').to_s,
            sme: rand < 0.5,
            supplier_frameworks: [
              {
                framework_id: 'RM6374',
                enabled: true,
                supplier_framework_contact_detail: {
                  email: Faker::Internet.email(name: supplier_name),
                  telephone_number: Faker::PhoneNumber.phone_number,
                  website: Faker::Internet.url(host: domain),
                  additional_details: {
                    address: Faker::Address.full_address,
                    description: Faker::Company.catch_phrase,
                    lot_1a_prospectus_link: Faker::Internet.url(host: domain),
                    lot_1b_prospectus_link: Faker::Internet.url(host: domain),
                    lot_1c_prospectus_link: Faker::Internet.url(host: domain),
                    lot_2_prospectus_link: Faker::Internet.url(host: domain),
                    lot_3_prospectus_link: Faker::Internet.url(host: domain),
                    lot_4_prospectus_link: Faker::Internet.url(host: domain),
                    lot_5_prospectus_link: Faker::Internet.url(host: domain),
                    lot_6_prospectus_link: Faker::Internet.url(host: domain),
                  }
                },
                supplier_framework_lots: []
              }
            ]
          }
        end
      end

      def self.generate_lot_data
        generate_static_lot_data(..5, '1a')
        generate_static_lot_data(5..10, '1b')
        generate_static_lot_data(10..15, '1c')
        generate_static_lot_data(15..20, '2')
        generate_static_lot_data(20..25, '3')
        generate_static_lot_data(25..30, '4')
        generate_static_lot_data(30..35, '5')
        generate_static_lot_data(35..40, '6')
        generate_random_lot_data(3..4, '1b')
        generate_random_lot_data(8..9, '1c')
        generate_random_lot_data(13..14, '2')
        generate_random_lot_data(18..19, '3')
        generate_random_lot_data(23..24, '4')
        generate_random_lot_data(28..29, '5')
        generate_random_lot_data(33..34, '6')
        generate_random_lot_data(38..39, '1a')
      end

      def self.generate_rate_cards
        generate_static_rates(..5, '1a')
        generate_static_rates(5..10, '1b')
        generate_static_rates(10..15, '1c')
        generate_static_rates(15..20, '2')
        generate_static_rates(20..25, '3')
        generate_static_rates(25..30, '4')
        generate_static_rates(30..35, '5')
        generate_static_rates(35..40, '6')
        generate_random_rates(3..4, '1b')
        generate_random_rates(8..9, '1c')
        generate_random_rates(13..14, '2')
        generate_random_rates(18..19, '3')
        generate_random_rates(23..24, '4')
        generate_random_rates(28..29, '5')
        generate_random_rates(33..34, '6')
        generate_random_rates(38..39, '1a')
      end

      def self.generate_static_lot_data(supplier_range, lot_number)
        lot_id = "RM6374.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          generate_services(supplier, lot_id, SERVICE_NUMBERS[lot_number])
        end
      end

      def self.generate_random_lot_data(supplier_range, lot_number)
        lot_id = "RM6374.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          serivce_numbers = SERVICE_NUMBERS[lot_number].sample([rand((SERVICE_NUMBERS[lot_number].length * (1 / 4.0)).to_i..(SERVICE_NUMBERS[lot_number].length * (3 / 4.0)).to_i), 1].max).sort

          generate_services(supplier, lot_id, serivce_numbers)
        end
      end

      def self.generate_services(supplier, lot_id, serivce_numbers)
        supplier_framework_lot = { lot_id: lot_id, enabled: true, supplier_framework_lot_services: [], supplier_framework_lot_rates: [], supplier_framework_lot_branches: [], supplier_framework_lot_jurisdictions: [{ jurisdiction_id: 'RM6374.GB' }] }

        serivce_numbers.each do |service_number|
          supplier_framework_lot[:supplier_framework_lot_services].append({ service_id: "#{lot_id}.#{service_number}" })
        end

        supplier[:supplier_frameworks][0][:supplier_framework_lots].append(supplier_framework_lot)
      end

      SERVICE_NUMBERS = {
        '1a' => (1..60).map(&:to_s),
        '1b' => (1..60).map(&:to_s),
        '1c' => (1..60).map(&:to_s),
        '2' => (1..69).map(&:to_s),
        '3' => (1..9).map(&:to_s),
        '4' => (1..11).map(&:to_s),
        '5' => (1..23).map(&:to_s),
        '6' => (1..2).map(&:to_s),
      }.freeze

      def self.generate_static_rates(supplier_range, lot_number)
        lot_id = "RM6374.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots].find { |supplier_framework_lot| supplier_framework_lot[:lot_id] == lot_id }
          jurisdiction_codes = JURISDICTION_CODES
          positions_ids = lot_number == '6' ? LOT_6_POSITIONS : NORMAL_POSITIONS

          generate_rates(supplier_framework_lot, lot_id, jurisdiction_codes, positions_ids)
        end
      end

      def self.generate_random_rates(supplier_range, lot_number)
        lot_id = "RM6374.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots].find { |supplier_framework_lot| supplier_framework_lot[:lot_id] == lot_id }
          jurisdiction_codes = JURISDICTION_CODES.sample(rand(1..3)).sort_by { |jurisdiction_code| JURISDICTION_CODES.index(jurisdiction_code) }
          positions_ids = lot_number == '6' ? LOT_6_POSITIONS : NORMAL_POSITIONS

          generate_rates(supplier_framework_lot, lot_id, jurisdiction_codes, positions_ids)
        end
      end

      def self.generate_rates(supplier_framework_lot, lot_id, jurisdiction_codes, position_ids)
        min_rate = rand(5..7) * 1000

        position_ids.each do |position_id|
          supplier_framework_lot[:supplier_framework_lot_rates].append(
            {
              rate: position_rate(min_rate, position_id),
              position_id: "#{lot_id}.#{position_id}",
              jurisdiction_id: 'RM6374.GB'
            }
          )
        end

        jurisdiction_codes.each do |jurisdiction_code|
          supplier_framework_lot[:supplier_framework_lot_jurisdictions].append(
            {
              jurisdiction_id: "RM6374.#{jurisdiction_code}"
            }
          )
        end
      end

      def self.position_rate(min_rate, position_id)
        (min_rate * POSITION_FACTOR[position_id]).to_i
      end

      NORMAL_POSITIONS = (1..9).to_a.freeze
      LOT_6_POSITIONS = (1..4).to_a.freeze
      JURISDICTION_CODES = %w[EW SC NI].freeze
      POSITION_FACTOR = {
        1 => 4.5,
        2 => 4,
        3 => 3.5,
        4 => 3,
        5 => 2.5,
        6 => 2,
        7 => 1.5,
        8 => 1,
        9 => 2.5,
      }.freeze

      def self.write_to_file
        File.write('data/legal_services/rm6374/dummy_supplier_data.json', JSON.pretty_generate(@suppliers))
      end
    end
    # rubocop:enable Metrics/ModuleLength
  end
end

namespace :generate_test_data do
  namespace :ls do
    desc 'Generate test data for Legal Services RM6374'
    task rm6374: :environment do
      GenerateTestData::LS::RM6374.generate_data
    end
  end
end
