module SupplyTeachers
  module RM6238
    module Admin
      class DataImport::GeneratePricing < SupplyTeachers::DataImport::GeneratePricing
        include SupplyTeachers::RM6238::Admin::DataImport::Helper

        private

        def pricing
          pricing_data = []

          read_spreadsheet(@current_data.pricing_for_tool) do |price_workbook|
            pricing_data = lot_pricing_data(price_workbook, '1')
            pricing_data += lot_pricing_data(price_workbook, '2.1')
            pricing_data += lot_pricing_data(price_workbook, '2.2')
            pricing_data += lot_pricing_data(price_workbook, '4')
          end

          pricing_data
        end

        def lot_pricing_data(price_workbook, lot_number)
          pricing_sheet = price_workbook.sheet("Lot #{lot_number}")

          pricing_sheet.map.with_index(1) { |row, index| add_headings(row).merge(line_no: index) }
                       .reject         { |row| subhead?(row) }
                       .map            { |row| symbolize_job_types(strip_fields(row), 'pricing_for_tool') }
                       .flat_map       { |row| normalize_pricing(row) }
                       .reject         { |row| invalid_fee?(row) }
                       .map { |row| nest(clean_up_pricing_data(row, lot_number), :pricing) }
        end

        def add_headings(row)
          %i[number supplier_name job_type fee1 fee2].zip(row).to_h
        end

        def normalize_pricing(row)
          case row[:job_type]
          when :nominated, :fixed_term, :over_12_week
            row.merge(fee: row[:fee1])
          when :agency_management_daily
            row.merge(term: :daily, fee: row[:fee1])
          when :agency_management_long_term
            row.merge(term: :six_weeks_plus, fee: row[:fee1])
          else
            [
              row.merge(term: :daily, fee: row[:fee1]),
              row.merge(term: :six_weeks_plus, fee: row[:fee2])
            ]
          end
        end

        def clean_up_pricing_data(row, lot_number)
          row = remove_unused_keys(row)
          row[:job_type] = :agency_management if %i[agency_management_daily agency_management_long_term].include?(row[:job_type])
          row[:fee] = (row[:fee].to_d * if percentage?(row)
                                          10000
                                        else
                                          100
                                        end).to_i

          row[:lot_number] = lot_number

          row
        end

        def percentage?(row)
          %i[fixed_term over_12_week].include?(row[:job_type])
        end
      end
    end
  end
end
