module GenerateTestData
  module ST
    # rubocop:disable Metrics/ModuleLength
    module RM6376
      def self.generate_data
        generate_suppliers
        generate_managed_service_provider_data(..4)
        add_supplier_framework_lots(..4, '2')
        add_supplier_framework_lots(3.., '1')
        add_supplier_framework_lot_branches(3..)
        add_supplier_framework_lot_rates(..4, '2')
        add_supplier_framework_lot_rates(3.., '1')
        write_to_file
      end

      def self.generate_suppliers
        @suppliers = (0..17).map do
          supplier_name = Faker::Company.unique.name.upcase

          {
            id: SecureRandom.uuid,
            name: supplier_name,
            supplier_frameworks: [
              {
                framework_id: 'RM6376',
                enabled: true,
                supplier_framework_contact_detail: {},
                supplier_framework_lots: []
              }
            ]
          }
        end
      end

      def self.generate_managed_service_provider_data(range)
        @suppliers[range].each do |supplier|
          supplier[:supplier_frameworks].each do |supplier_framework|
            supplier_framework[:supplier_framework_contact_detail][:additional_details] = {
              managed_service_provider: {
                name: Faker::Name.unique.name,
                telephone: Faker::PhoneNumber.phone_number,
                email: Faker::Internet.email(name: supplier[:name])
              }
            }
          end
        end
      end

      def self.add_supplier_framework_lots(range, lot_number)
        @suppliers[range].each do |supplier|
          supplier[:supplier_frameworks].each do |supplier_framework|
            supplier_framework[:supplier_framework_lots] << { lot_id: "#{supplier_framework[:framework_id]}.#{lot_number}", enabled: true, supplier_framework_lot_services: [], supplier_framework_lot_rates: [], supplier_framework_lot_branches: [], supplier_framework_lot_jurisdictions: [{ jurisdiction_id: 'GB' }] }
          end
        end
      end

      def self.add_supplier_framework_lot_branches(range)
        @suppliers[range].each.with_index do |supplier, index|
          supplier[:supplier_frameworks].each do |supplier_framework|
            supplier_framework[:supplier_framework_lots].each do |supplier_framework_lot|
              next if supplier_framework_lot[:lot_id] != "#{supplier_framework[:framework_id]}.1"

              supplier_framework_lot[:supplier_framework_lot_branches] << get_branch_data('London', index)
              supplier_framework_lot[:supplier_framework_lot_branches] << get_branch_data('Liverpool', index)
              supplier_framework_lot[:supplier_framework_lot_branches] << get_branch_data('Birmingham', index)
            end
          end
        end
      end

      def self.add_supplier_framework_lot_rates(range, lot_number)
        @suppliers[range].each do |supplier|
          supplier[:supplier_frameworks].each do |supplier_framework|
            supplier_framework[:supplier_framework_lots].each do |supplier_framework_lot|
              next if supplier_framework_lot[:lot_id] != "#{supplier_framework[:framework_id]}.#{lot_number}"

              get_rats_for_supplier(rand(3000..7000), lot_number) do |rate|
                supplier_framework_lot[:supplier_framework_lot_rates] << rate
              end
            end
          end
        end
      end

      def self.write_to_file
        File.write('data/supply_teachers/rm6376/dummy_supplier_data.json', JSON.pretty_generate(@suppliers))
      end

      def self.get_rats_for_supplier(base_rate, lot_number)
        JOB_TYPES.each.with_index(1) do |job_type, position_number|
          yield({
            position_id: "RM6376.#{lot_number}.#{position_number}",
            rate: determin_base_fee_for_job(base_rate, job_type),
            jurisdiction_id: 'GB'
          })
        end
      end

      def self.determin_base_fee_for_job(base_fee, job_type)
        (base_fee * JOB_TYPE_MULTIPLIER[job_type]).floor
      end

      def self.get_branch_data(location, index)
        address_index = case location
                        when 'London'
                          index % 5
                        when 'Liverpool'
                          4 - (index % 5)
                        when 'Birmingham'
                          (3 - index) % 5
                        end

        address = LONDON_AND_LIVERPOOL_ADDRESSES[location][address_index]
        contact_name = Faker::Name.unique.name

        {
          lat: address[:lat],
          lon: address[:lon],
          postcode: address[:postcode],
          contact_name: contact_name,
          contact_email: Faker::Internet.email(name: contact_name),
          telephone_number: Faker::PhoneNumber.phone_number,
          name: address[:town],
          town: address[:town],
          address_line_1: address[:address_1],
          address_line_2: address[:address_2],
          county: address[:county],
          region: address[:region],
        }
      end

      JOB_TYPES = %w[stem_teacher non_stem_teacher educationl_support_non_send educationl_support_send senior_roles facilities_management admin_and_clerical other over_12_week nominated_worker fixed_term].freeze
      JOB_TYPE_MULTIPLIER = { 'stem_teacher' => 1.2, 'non_stem_teacher' => 1, 'educationl_support_non_send' => 0.7, 'educationl_support_send' => 0.9, 'senior_roles' => 1.2, 'facilities_management' => 0.8, 'admin_and_clerical' => 0.75, 'other' => 0.5, 'over_12_week' => 0.95, 'nominated_worker' => 1.05, 'fixed_term' => 0.85 }.freeze
      LONDON_AND_LIVERPOOL_ADDRESSES = {
        'London' => [
          # < 1 mile
          { town: 'London', address_1: '10 South Colonnade', region: 'Inner London - East', postcode: 'E14 4PU', lat: 51.50458599115668, lon: -0.02208052729799974 },
          # < 5 mile
          { town: 'London', address_1: 'London Stadium', address_2: 'Queen Elizabeth Olympic Park', region: 'Inner London - East', postcode: 'E20 2ST', lat: 51.53856612802023, lon: -0.016517049198377255 },
          # < 10 mile
          { town: 'London', address_1: 'Buckingham Palace', region: 'Inner London - West', postcode: 'SW1A 1AA', lat: 51.50306085083827, lon: -0.1447072660356099 },
          # < 25 miles
          { town: 'Twickenham', county: 'London', address_1: 'Twickenham Stadium', address_2: '200 Whitton Rd', region: 'Outer London - West and North West', postcode: 'TW2 7BA', lat: 51.46190833253159, lon: -0.340934872716188 },
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
        ],
        'Birmingham' => [
          # < 1 mile
          { town: 'Birmingham', county: 'West Midlands', address_1: '23 Stephenson St', region: 'Birmingham', postcode: 'B2 4BJ', lat: 52.4789997328729, lon: -1.9007014905137978 },
          # < 5 mile
          { town: 'Birmingham', county: 'West Midlands', address_1: 'Villa Park', address_2: 'Trinity Rd', region: 'Birmingham', postcode: 'B6 6HE', lat: 52.50948941053984, lon: -1.8839958035018183 },
          # # < 10 mile
          { town: 'Dudley', county: 'West Midlands', address_1: 'Discovery Wy', region: 'Birmingham', postcode: 'DY1 4AL', lat: 52.524659858134505, lon: -2.047541022496625 },
          # < 25 miles
          { town: 'Wolverhampton', county: 'West Midlands', address_1: 'Molineux Stadium', address_2: 'Waterloo Rd', region: 'Wolverhampton', postcode: 'WV1 4QR', lat: 52.59117109252977, lon: -2.1304508109396623 },
          # # < 50 miles
          { town: 'Nottingham', county: 'Nottinghamshire', address_1: 'Trent Bridge', address_2: 'West Bridgford', region: 'Nottingham', postcode: 'NG2 6AG', lat: 52.93691728961155, lon: -1.1322526160932878 },
        ]
      }.freeze
    end
    # rubocop:enable Metrics/ModuleLength
  end
end

namespace :generate_test_data do
  namespace :st do
    desc 'Generate test data for Supply Teachers RM6376'
    task rm6376: :environment do
      GenerateTestData::ST::RM6376.generate_data
    end
  end
end
