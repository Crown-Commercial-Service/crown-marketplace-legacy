module SupplyTeachers
  module RM6238
    module Admin
      class DataConverter
        class << self
          def convert_data(suppliers)
            suppliers.map do |supplier_data|
              supplier = {
                id: supplier_data['supplier_id'],
                name: supplier_data['supplier_name'],
                supplier_frameworks: [
                  {
                    framework_id: 'RM6238',
                    enabled: true
                  }
                ]
              }

              add_contact_details(supplier, supplier_data)
              supplier_framework_lots = add_pricing_and_branches(supplier_data)

              supplier[:supplier_frameworks][0][:supplier_framework_lots] = []

              supplier_framework_lots.each do |lot_id, supplier_framework_lot_data|
                supplier[:supplier_frameworks][0][:supplier_framework_lots] << {
                  lot_id: lot_id,
                  enabled: true,
                  supplier_framework_lot_services: supplier_framework_lot_data[:services],
                  supplier_framework_lot_jurisdictions: supplier_framework_lot_data[:jurisdictions],
                  supplier_framework_lot_rates: supplier_framework_lot_data[:rates],
                  supplier_framework_lot_branches: supplier_framework_lot_data[:branches],
                }
              end

              supplier
            end
          end

          private

          def add_contact_details(supplier, supplier_data)
            supplier[:supplier_frameworks][0][:supplier_framework_contact_detail] = {}

            [
              ['master_vendor_contacts', :master_vendor],
              ['education_technology_platform_contacts', :education_technology_platform]
            ].each do |supplier_data_key, supplier_key|
              next unless supplier_data.key?(supplier_data_key)

              supplier[:supplier_frameworks][0][:supplier_framework_contact_detail][:additional_details] ||= {}
              supplier[:supplier_frameworks][0][:supplier_framework_contact_detail][:additional_details][supplier_key] = {
                name: supplier_data.dig(supplier_data_key, 'name'),
                email: supplier_data.dig(supplier_data_key, 'email'),
                telephone_number: supplier_data.dig(supplier_data_key, 'telephone'),
              }
            end
          end

          def add_pricing_and_branches(supplier_data)
            supplier_framework_lots = {}

            add_pricing(supplier_framework_lots, supplier_data)
            add_branches(supplier_framework_lots, supplier_data)

            supplier_framework_lots
          end

          def add_pricing(supplier_framework_lots, supplier_data)
            supplier_data['pricing'].each do |pricing|
              lot_id = "RM6238.#{pricing['lot_number']}"
              position_number = (pricing['lot_number'] == '4' ? JOB_TYPE_TO_POSITION_NUMBER_LOT_4 : JOB_TYPE_TO_POSITION_NUMBER)[pricing['job_type']][pricing['term']]

              supplier_framework_lots[lot_id] ||= { services: [], jurisdictions: [{ jurisdiction_id: 'GB' }], rates: [], branches: [] }
              supplier_framework_lots[lot_id][:rates] << {
                position_id: "#{lot_id}.#{position_number}",
                rate: pricing['fee'],
                jurisdiction_id: 'GB'
              }
            end
          end

          def add_branches(supplier_framework_lots, supplier_data)
            supplier_data['branches']&.each do |branch|
              lot_id = 'RM6238.1'
              supplier_framework_lots[lot_id] ||= { services: [], jurisdictions: [{ jurisdiction_id: 'GB' }], rates: [], branches: [] }
              supplier_framework_lots[lot_id][:branches] << {
                lat: branch['lat'],
                lon: branch['lon'],
                postcode: branch['postcode'],
                contact_name: branch['contacts'][0]['name'],
                contact_email: branch['contacts'][0]['email'],
                telephone_number: branch['telephone'],
                name: branch['branch_name'],
                town: branch['town'],
                address_line_1: branch['address_1'],
                address_line_2: branch['address_2'],
                county: branch['county'],
                region: branch['region'],
              }
            end
          end

          JOB_TYPE_TO_POSITION_NUMBER = {
            'over_12_week' => {
              nil => 9
            },
            'nominated' => {
              nil => 10
            },
            'fixed_term' => {
              nil => 11
            },
            'teacher' => {
              'daily' => 1,
              'six_weeks_plus' => 2
            },
            'support' => {
              'daily' => 3,
              'six_weeks_plus' => 4
            },
            'senior' => {
              'daily' => 5,
              'six_weeks_plus' => 6
            },
            'other' => {
              'daily' => 7,
              'six_weeks_plus' => 8
            },

          }.freeze

          JOB_TYPE_TO_POSITION_NUMBER_LOT_4 = {
            'nominated' => {
              nil => 3
            },
            'fixed_term' => {
              nil => 4
            },
            'agency_management' => {
              'daily' => 1,
              'six_weeks_plus' => 2
            }
          }.freeze
        end
      end
    end
  end
end
