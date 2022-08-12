module GenerateTestData
  module ST
    # rubocop:disable Metrics/ModuleLength
    module RM3826
      def self.generate_data
        generate_suppliers
        generate_master_vendor_data
        add_supplier_branches
        add_supplier_pricing
        write_to_file
      end

      def self.generate_suppliers
        @suppliers = (0..13).map do
          supplier_name = Faker::Company.unique.name.upcase
          {
            supplier_id: SecureRandom.uuid,
            supplier_name: supplier_name,
            branches: [],
            pricing: [],
            master_vendor_pricing: [],
            master_vendor_contact: {}
          }
        end
      end

      def self.generate_master_vendor_data
        @suppliers[..3].each do |supplier|
          supplier[:master_vendor_contact] = {
            name: Faker::Name.unique.name,
            telephone: Faker::PhoneNumber.phone_number,
            email: Faker::Internet.email(name: supplier[:supplier_name])
          }

          add_pricing_for_supplier(supplier, :master_vendor_pricing, rand(150..300))
        end
      end

      def self.add_supplier_branches
        @suppliers[4..].each.with_index do |supplier, index|
          supplier[:branches] << get_branch_data('London', index)
          supplier[:branches] << get_branch_data('Liverpool', index)
        end
      end

      def self.add_supplier_pricing
        @suppliers[4..].each.with_index do |supplier, supplier_index|
          add_pricing_for_supplier(supplier, :pricing, rand(250..600), supplier_index)
        end
      end

      def self.write_to_file
        File.open('data/supply_teachers/rm3826/dummy_supplier_data.json', 'w') do |file|
          file.write(JSON.pretty_generate(@suppliers))
        end
      end

      def self.add_pricing_for_supplier(supplier, key, base_rate, supplier_index = 0)
        MASTER_VENDOR_JOB_TYPES.each.with_index do |job_type, index|
          base_fee_for_job = determin_base_fee_for_job(base_rate, index)

          if index < 8
            next if supplier_index > 4 && rand > 0.5

            MASTER_VENDOR_TERMS.each do |term|
              supplier[key] << {
                job_type: job_type,
                term: term,
                fee: (base_fee_for_job * TERM_MULTIPLIER[term]).floor / 1000.0
              }
            end
          else
            supplier[key] << {
              job_type: job_type,
              term: nil,
              fee: base_fee_for_job / 1000.0
            }
          end
        end
      end

      def self.determin_base_fee_for_job(base_fee, index)
        if index < 4
          (base_fee * (0.9**index)).floor
        elsif index < 8
          base_fee
        else
          (base_fee / 2).floor
        end
      end

      def self.get_branch_data(location, index)
        address_index = location == 'London' ? index % 5 : 4 - index % 5

        address = LONDON_AND_LIVERPOOL_ADDRESSES[location][address_index]
        contact_name = Faker::Name.unique.name

        {
          branch_name: address[:town],
          town: address[:town],
          address_1: address[:address_1],
          address_2: address[:address_2],
          county: address[:county],
          region: address[:region],
          postcode: address[:postcode],
          lat: address[:lat],
          lon: address[:lon],
          telephone: Faker::PhoneNumber.phone_number,
          contacts: [
            {
              name: contact_name,
              email: Faker::Internet.email(name: contact_name)
            }
          ]
        }
      end

      MASTER_VENDOR_JOB_TYPES = %w[admin qt qt_sen senior support support_sen uqt uqt_sen fixed_term nominated].freeze
      MASTER_VENDOR_TERMS = %w[one_week twelve_weeks more_than_twelve_weeks].freeze
      TERM_MULTIPLIER = { 'one_week' => 1.0, 'twelve_weeks' => 0.95, 'more_than_twelve_weeks' => 0.9 }.freeze
      LONDON_AND_LIVERPOOL_ADDRESSES = {
        'London' => [
          # < 1 mile
          { town: 'London', address_1: '10 South Colonnade', region: 'Inner London - East', postcode: 'E14 4PU', lat: 51.50458599115668, lon: -0.02208052729799974 },
          # < 5 mile
          { town: 'London', address_1: 'London Stadium', address_2: 'Queen Elizabeth Olympic Park', region: 'Inner London - East', postcode: 'E20 2ST', lat: 51.53856612802023, lon: -0.016517049198377255 },
          # < 10 mile
          { town: 'London', address_1: 'Buckingham Palace', region: 'Inner London - West', postcode: 'SW1A 1AA', lat: 51.50306085083827, lon: -0.1447072660356099 },
          # < 25 miles
          { town: 'Twickenham', county: 'London', address_1: 'Twickenham Stadium', address_2: '200 Whitton Rd', region: 'IOuter London - West and North West', postcode: 'TW2 7BA', lat: 51.46190833253159, lon: -0.340934872716188 },
          # < 50 miles
          { town: 'Southend-on-Sea', county: 'Essex', address_1: 'Roots Hall', address_2: 'Victoria Ave', region: 'Essex', postcode: 'SS2 6NQ', lat: 51.549072447921404, lon: 0.7016791349027106 }
        ],
        'Liverpool' => [
          # < 1 mile
          { town: 'Liverpool', county: 'Merseyside', address_1: 'The Capital Building', address_2: 'Old Hall St', region: 'Merseyside', postcode: 'L3 9PP', lat: 53.40926484785927, lon: -2.9950993589489463 },
          # < 5 mile
          { town: 'Liverpool', county: 'Merseyside', address_1: 'Anfield', address_2: 'Anfield Rd', region: 'Merseyside', postcode: 'L4 0TH', lat: 53.43134641218853, lon: -2.960931536892127 },
          # < 10 mile
          { town: 'Liverpool', county: 'Merseyside', address_1: 'Liverpool John Lennon Airport', address_2: 'Speke Hall Ave', region: 'Merseyside', postcode: 'L24 1YD', lat: 53.33543706989522, lon: -2.8525950536169677 },
          # < 25 miles
          { town: 'Southport', county: 'Merseyside', address_1: 'Southport Pleasureland', address_2: 'Marine Dr', region: 'Merseyside', postcode: 'PR8 1RX', lat: 53.64815863047592, lon: -3.0172629561364004 },
          # < 50 miles
          { town: 'Manchester', county: 'Greater Manchester', address_1: 'Old Trafford', address_2: 'Sir Matt Busby Way', region: 'Greater Manchester', postcode: 'M16 0RA', lat: 53.46367330827036, lon: -2.2929726032049316 }
        ]
      }.freeze
    end
    # rubocop:enable Metrics/ModuleLength
  end
end

namespace :generate_test_data do
  namespace :st do
    desc 'Generate test data for  Management Consultancy'
    task rm3826: :environment do
      GenerateTestData::ST::RM3826.generate_data
    end
  end
end
