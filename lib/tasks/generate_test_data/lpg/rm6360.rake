module GenerateTestData
  module LPG
    # rubocop:disable Metrics/ModuleLength
    module RM6360
      def self.generate_data
        generate_suppliers
        generate_lot_data
        generate_rate_cards
        write_to_file
      end

      def self.generate_suppliers
        @suppliers = (0..60).map do
          supplier_name = Faker::Company.unique.name.upcase
          domain = Faker::Internet.domain_name(domain: supplier_name)

          {
            id: SecureRandom.uuid,
            name: supplier_name,
            duns_number: Faker::Company.unique.duns_number.delete('-').to_s,
            sme: rand < 0.5,
            supplier_frameworks: [
              {
                framework_id: 'RM6360',
                enabled: true,
                supplier_framework_contact_detail: {
                  email: Faker::Internet.email(name: supplier_name),
                  telephone_number: Faker::PhoneNumber.phone_number,
                  website: Faker::Internet.url(host: domain),
                  additional_details: {
                    address: Faker::Address.full_address,
                    lot_1_prospectus_link: Faker::Internet.url(host: domain),
                    lot_2_prospectus_link: Faker::Internet.url(host: domain),
                    lot_3_prospectus_link: Faker::Internet.url(host: domain),
                    lot_4a_prospectus_link: Faker::Internet.url(host: domain),
                    lot_4b_prospectus_link: Faker::Internet.url(host: domain),
                    lot_4c_prospectus_link: Faker::Internet.url(host: domain),
                    lot_5_prospectus_link: Faker::Internet.url(host: domain),
                  }
                },
                supplier_framework_lots: []
              }
            ]
          }
        end
      end

      def self.generate_lot_data
        generate_static_lot_data(..2, '1')
        generate_static_lot_data(2..4, '2')
        generate_static_lot_data(4..6, '3')
        generate_static_lot_data(6..8, '4a')
        generate_static_lot_data(8..10, '4b')
        generate_static_lot_data(10..12, '4c')
        generate_static_lot_data(12..14, '5')
        generate_random_lot_data(3..5, '1')
        generate_random_lot_data(6..8, '2')
        generate_random_lot_data(9..11, '3')
        generate_random_lot_data(12..14, '4a')
        generate_random_lot_data(15..17, '4b')
        generate_random_lot_data(18..20, '4c')
        generate_random_lot_data(21..23, '5')
      end

      def self.generate_rate_cards
        generate_static_rates(..2, '1')
        generate_static_rates(2..4, '2')
        generate_static_rates(4..6, '3')
        generate_static_rates(12..14, '5')
        generate_static_rates(3..5, '1')
        generate_static_rates(6..8, '2')
        generate_static_rates(9..11, '3')
        generate_static_rates(21..23, '5')
        generate_static_rates_lot_4(6..8, '4a')
        generate_static_rates_lot_4(8..10, '4b')
        generate_static_rates_lot_4(10..12, '4c')
        generate_random_rates_lot_4(12..14, '4a')
        generate_random_rates_lot_4(15..17, '4b')
        generate_random_rates_lot_4(18..20, '4c')
      end

      def self.generate_static_lot_data(supplier_range, lot_number)
        lot_id = "RM6360.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          generate_services(supplier, lot_id, SERVICE_NUMBERS[lot_number])
        end
      end

      def self.generate_random_lot_data(supplier_range, lot_number)
        lot_id = "RM6360.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          serivce_numbers = SERVICE_NUMBERS[lot_number].sample(rand((SERVICE_NUMBERS[lot_number].length * (1 / 4.0)).to_i..(SERVICE_NUMBERS[lot_number].length * (3 / 4.0)).to_i)).sort

          generate_services(supplier, lot_id, serivce_numbers)
        end
      end

      def self.generate_services(supplier, lot_id, serivce_numbers)
        supplier_framework_lot = { lot_id: lot_id, enabled: true, supplier_framework_lot_services: [], supplier_framework_lot_rates: [], supplier_framework_lot_branches: [], supplier_framework_lot_jurisdictions: [] }

        serivce_numbers.each do |service_number|
          supplier_framework_lot[:supplier_framework_lot_services].append({ service_id: "#{lot_id}.#{service_number}" })
        end

        supplier[:supplier_frameworks][0][:supplier_framework_lots].append(supplier_framework_lot)
      end

      SERVICE_NUMBERS = {
        '1' => (1..48).map(&:to_s),
        '2' => (1..59).map(&:to_s),
        '3' => (1..23).map(&:to_s),
        '4a' => (1..10).map(&:to_s),
        '4b' => (1..9).map(&:to_s),
        '4c' => (1..5).map(&:to_s),
        '5' => (1..20).map(&:to_s),
      }.freeze

      def self.generate_static_rates(supplier_range, lot_number)
        lot_id = "RM6360.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots].find { |supplier_framework_lot| supplier_framework_lot[:lot_id] == lot_id }
          jurisdiction_ids = ['GB']
          positions_ids = NORMAL_POSITIONS

          generate_rates(supplier_framework_lot, jurisdiction_ids, positions_ids)
        end
      end

      def self.generate_static_rates_lot_4(supplier_range, lot_number)
        lot_id = "RM6360.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots].find { |supplier_framework_lot| supplier_framework_lot[:lot_id] == lot_id }
          jurisdiction_ids = fetch_jurisdiction_ids
          positions_ids = LOT_4_MANDATORY_POSITIONS + LOT_4_OPTIONAL_POSITIONS

          generate_rates(supplier_framework_lot, jurisdiction_ids, positions_ids)
        end
      end

      # rubocop:disable Metrics/AbcSize
      def self.generate_random_rates_lot_4(supplier_range, lot_number)
        lot_id = "RM6360.#{lot_number}"

        @suppliers[supplier_range].each do |supplier|
          supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots].find { |supplier_framework_lot| supplier_framework_lot[:lot_id] == lot_id }
          jurisdiction_ids = (['GB'] + fetch_jurisdiction_ids.sample(rand((fetch_jurisdiction_ids.length * (1 / 4.0)).to_i..(fetch_jurisdiction_ids.length * (3 / 4.0)).to_i))).uniq.sort
          positions_ids = LOT_4_MANDATORY_POSITIONS + LOT_4_OPTIONAL_POSITIONS.sample(rand(LOT_4_OPTIONAL_POSITIONS.length))

          generate_rates(supplier_framework_lot, jurisdiction_ids, positions_ids)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def self.generate_rates(supplier_framework_lot, jurisdiction_ids, position_ids)
        jurisdiction_ids.each do |jurisdiction_id|
          min_rate = rand(5..7) * 1000

          position_ids.each do |position_id|
            supplier_framework_lot[:supplier_framework_lot_rates].append(
              {
                rate: position_rate(min_rate, position_id),
                position_id: position_id,
                jurisdiction_id: jurisdiction_id
              }
            )
          end

          supplier_framework_lot[:supplier_framework_lot_jurisdictions].append(
            {
              jurisdiction_id:
            }
          )
        end
      end

      def self.position_rate(min_rate, position_id)
        (min_rate * POSITION_FACTOR[position_id]).to_i
      end

      def self.fetch_jurisdiction_ids
        @fetch_jurisdiction_ids ||= Jurisdiction.where.not(id: %w[BE CH DE FR IE US CA]).order(:id).pluck(:id)
      end

      NORMAL_POSITIONS = [1, 51, 52, 53, 54, 55, 6].freeze
      LOT_4_MANDATORY_POSITIONS = [56, 1, 51, 52, 53, 54, 55, 6].freeze
      LOT_4_OPTIONAL_POSITIONS = [57, 58, 59, 60].freeze

      POSITION_FACTOR = {
        56 => 4.5,
        1 => 4,
        51 => 3.5,
        52 => 3,
        53 => 2.5,
        54 => 2,
        55 => 1.5,
        6 => 1,
        57 => 2.5,
        58 => 2,
        59 => 3,
        60 => 2.5,
      }.freeze

      def self.write_to_file
        File.write('data/legal_panel_for_government/rm6360/dummy_supplier_data.json', JSON.pretty_generate(@suppliers))
      end
    end
    # rubocop:enable Metrics/ModuleLength
  end
end

namespace :generate_test_data do
  namespace :lpg do
    desc 'Generate test data for Legal Panel for Government RM6360'
    task rm6360: :environment do
      GenerateTestData::LPG::RM6360.generate_data
    end
  end
end
