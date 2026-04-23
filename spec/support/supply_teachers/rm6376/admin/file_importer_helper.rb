module SupplyTeachers
  module RM6376
    module Admin
      class FileImporterHelper
        def initialize(**options)
          @package = Axlsx::Package.new
          @sheets = options[:sheets]
          @headers = options[:headers]
          @supplier_no_lots = options[:supplier_no_lots] || []
          @supplier_no_branches = options[:supplier_no_branches] || []
          @supplier_no_branch_data = options[:supplier_no_branch_data] || []
          @supplier_no_rates = options[:supplier_no_rates] || []
          @empty = options[:empty] || false
        end

        def write
          File.write(self.class::OUTPUT_PATH, @package.to_stream.read, binmode: true)
        end

        SUPPLIERS = [
          ['NOAH LTD', 'NOAH LTD', '123456', '', '', '', 'X', ''],
          ['MIO CORP', 'MIO CORP', '234561', '', '', '', 'X', ''],
          ['REKU LTD', 'COMMON VARIETY NOPON', '345612', 'Reku', 'reku@xenoblade3.com', '0204 345 6789', 'X', 'X'],
          ['GUERNICA EXEC CORP', 'GUERNICA EXEC CORP', '456123', 'Guernica', 'guernica@xenoblade3.com', '0205 456 7890', '', 'X'],
          ['ETHEL LTD', 'COLONY 4', '561234', 'Ethel', 'ethel@xenoblade3.com', '0204 567 8901', '', 'X'],
        ].freeze

        def suppliers(sheet_name)
          case sheet_name
          when 'Lot 1'
            SUPPLIERS[..2]
          else
            SUPPLIERS[2..]
          end
        end
      end

      class SupplierDetailsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= [HEADERS] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_supplier_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_details_file.xlsx'.freeze

        SHEETS = ['All Suppliers'].freeze
        HEADERS = ['Supplier Name', 'Supplier Trading Name', 'Supplier Identifier', 'Managed service provider contact name', 'Managed service provider contact email', 'Managed service provider contact telephone', 'Lot 1', 'Lot 2'].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            headers = self::HEADERS
            headers += ['Extra'] if sheets_with_extra_headers.include? sheet
            headers
          end
        end

        private

        def add_supplier_sheet(sheet_name, header_row)
          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row
            next if @empty

            SUPPLIERS.each do |supplier_detail|
              sheet.add_row @supplier_no_lots.include?(supplier_detail[2]) ? supplier_detail[..5] : supplier_detail
            end
          end
        end
      end

      class SupplierGeographicalDataFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= [HEADERS] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_supplier_geographical_data_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_geographical_data_file.xlsx'.freeze

        SHEETS = ['Branch details'].freeze
        HEADERS = ['Supplier Name', 'Supplier Identifier', 'Branch Name/No.', 'Branch Contact name', 'Address 1', 'Address 2', 'Town', 'County', 'Post Code', 'Branch Contact Name Email Address', 'Branch Telephone Number', 'Region'].freeze
        BRANCHES = [
          ['NOAH LTD', '123456', 'Twickenham', 'Elna Lemke', 'Twickenham Stadium', '200 Whitton Rd', 'Twickenham', 'London', 'TW2 7BA', 'lemke.elna@kozey.test', '(513) 948 9721', 'Outer London - West and North West'],
          ['NOAH LTD', '123456', 'Liverpool', 'Norbert Barton', 'Anfield', 'Anfield Rd', 'Liverpool', 'Merseyside', 'L4 0TH', 'norbert_barton@vonrueden-lakin.test', '440.479.6390', 'Merseyside'],
          ['MIO CORP', '234561', 'Liverpool', 'Asa Lueilwitz', 'Anfield', 'Anfield Rd', 'Liverpool', 'Merseyside', 'L4 0TH', 'asa_lueilwitz@rath.test', '(307) 339-4952', 'Merseyside'],
          ['MIO CORP', '234561', 'Birmingham', 'Gov. Garland Rau', '23 Stephenson St', '', 'Birmingham', 'West Midlands', 'B2 4BJ', 'gov_rau_garland@yundt.test', '2293891820', 'Birmingham'],
          ['REKU LTD', '345612', 'London', 'Gail Koepp', 'London Stadium', 'Queen Elizabeth Olympic Park', 'London', '', 'E20 2ST', 'koepp.gail@schaefer.example', '574-804-5257', 'Inner London - East'],
          ['REKU LTD', '345612', 'Dudley', 'Hassan Hermann I', 'Discovery Wy', '', 'Dudley', 'West Midlands', 'DY1 4AL', 'i.hermann.hassan@marks.example', '634-601-6156', 'Birmingham'],
        ].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            headers = self::HEADERS
            headers += ['Extra'] if sheets_with_extra_headers.include? sheet
            headers
          end
        end

        private

        def add_supplier_geographical_data_sheet(sheet_name, header_row)
          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row
            next if @empty

            BRANCHES.each do |branch|
              next if @supplier_no_branches.include?(branch[1])

              sheet.add_row @supplier_no_branch_data.include?(branch[1]) ? (branch[..7] + ['FAKE PC'] + branch[9..]) : branch
            end
          end
        end
      end

      class SupplierRateCardsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= [[self.class::HEADERS_1, self.class::HEADERS_2]] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_rate_card_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_rate_cards_file.xlsx'.freeze

        SHEETS = ['Lot 1', 'Lot 2',].freeze

        HEADERS_1 = [nil, 'Position:', 'STEM Teacher', 'Non-STEM Teachers', 'Educational Support Staff non SEND', 'Educational Support Staff SEND', 'Senior Roles', 'Facilities Management', 'Admin & Clerical', 'Other', 'Over 12 Week Reduction', 'Nominated Workers', 'Fixed Term / Permanent Roles'].freeze
        HEADERS_2 = ['Supplier name', 'Supplier Identifier', '£', '£', '£', '£', '£', '£', '£', '£', '%', '%', '%'].freeze
        PRICES = [1789, 1458, 1247, 1036, 825, 614, 403, 212, 456, 312, 111].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            if sheets_with_extra_headers.include? sheet
              [self::HEADERS_1 + ['Extra'], self::HEADERS_2 + ['Extra']]
            else
              [self::HEADERS_1, self::HEADERS_2]
            end
          end
        end

        private

        def add_rate_card_sheet(sheet_name, header_row)
          supplier_details = suppliers(sheet_name)

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row[0]
            sheet.add_row header_row[1]
            next if @empty

            supplier_details.each do |supplier_detail|
              next if @supplier_no_rates.include?(supplier_detail[2])

              supplier_name = supplier_detail[0]
              supplier_identifier = supplier_detail[2]

              sheet.add_row [supplier_name, supplier_identifier] + PRICES
            end
          end
        end
      end
    end
  end
end
