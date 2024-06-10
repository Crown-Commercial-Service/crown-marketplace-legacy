module LegalServices
  module RM6240
    module Admin
      class FileImporterHelper
        def initialize(**options)
          @package = Axlsx::Package.new
          @sheets = options[:sheets]
          @headers = options[:headers]
          @supplier_duns = options[:supplier_duns] || {}
          @empty = options[:empty] || false
        end

        def supplier_heading_name(name, duns)
          "#{name} [#{duns}]"
        end

        def write
          File.write(self.class::OUTPUT_PATH, @package.to_stream.read, binmode: true)
        end

        SUPPLIERS_LOT_1 = [
          ['NOAH LTD', 'noah@xenoblade3.com', '0202 123 4567', 'www.noah.com', 'Keves AA3 1XC', 'Yes', '123456789'],
          ['MIO CORP', 'mio@xenoblade3.com', '0203 234 5678', 'www.mio.com', 'Agnus AA3 2XC', 'No', '234567891'],
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912']
        ].freeze

        SUPPLIERS_LOT_2 = [
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912'],
          ['GUERNICA EXEC CORP', 'guernica@xenoblade3.com', '0205 456 7890', 'www.guernica.com', 'Swordmarch AA3 4XC', 'No', '456789123'],
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234']
        ].freeze

        SUPPLIERS_LOT_3 = [
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234'],
          ['LANZ CORP', 'lanz@xenoblade3.com', '0205 678 9012', 'www.lanz.com', 'Colony 30 AA3 6XC', 'No', '678912345'],
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456']
        ].freeze
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
        HEADERS = ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link'].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            headers = self::HEADERS
            headers += ['Extra'] if sheets_with_extra_headers.include? sheet
            headers
          end
        end

        private

        def add_supplier_sheet(sheet_name, header_row)
          supplier_details = (SUPPLIERS_LOT_1 + SUPPLIERS_LOT_2 + SUPPLIERS_LOT_3).uniq

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row
            next if @empty

            supplier_details.each do |supplier_detail|
              sheet.add_row supplier_detail
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

        SHEETS = ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3'].freeze
        HEADERS_1 = [nil, 'Position:', 'Partner', 'Senior Solicitor, Senior Associate', 'Solicitor, Associate', 'NQ Solicitor/Associate, Junior Solicitor/Associate', 'Trainee', 'Paralegal, Legal Assistant', 'LMP (Legal project manager)'].freeze
        HEADERS_2 = ['Supplier name', 'DUNS', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate'].freeze
        PRICES = [1330, 1295, 1225, 1120, 700, 450].freeze

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

            supplier_details.each_with_index do |supplier_detail, index|
              supplier_name = supplier_detail[0]
              supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

              sheet.add_row [supplier_name, supplier_duns] + PRICES + [final_rate(index)]
            end
          end
        end

        def suppliers(sheet_name)
          if sheet_name.include? '3'
            SUPPLIERS_LOT_3
          elsif sheet_name.include? '2'
            SUPPLIERS_LOT_2
          else
            SUPPLIERS_LOT_1
          end
        end

        def final_rate(index)
          case index
          when 0
            1200
          when 1
            nil
          when 2
            ''
          end
        end
      end

      class SupplierLotFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= self.class::SHEETS
          options[:headers] ||= [self.class::HEADERS_1.zip(self.class::HEADERS_2)] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_column|
            add_service_offerings_sheet(sheet_name, header_column)
          end
        end

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            if sheets_with_extra_headers.include? sheet
              (self::HEADERS_1 + ['Extra']).zip(self::HEADERS_2 + ['Extra'])
            else
              self::HEADERS_1.zip(self::HEADERS_2)
            end
          end
        end

        private

        def add_service_offerings_sheet(sheet_name, header_column)
          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            @empty ? add_blank_sheet(sheet, header_column) : add_sheet_with_data(sheet, header_column)
          end
        end

        def add_blank_sheet(sheet, header_column)
          sheet.add_row header_column[0]
          sheet.add_row header_column[1]
          header_column[2..].each { |service| sheet.add_row service, types: %i[string string] }
        end

        def add_sheet_with_data(sheet, header_column)
          selection = self.class::BASE_SELECTION.dup
          supplier_name_headings = supplier_names(self.class::SUPPLIERS)

          sheet.add_row header_column[0] + supplier_name_headings[:names]
          sheet.add_row header_column[1] + supplier_name_headings[:duns]

          header_column[2..].each do |service|
            sheet.add_row service + selection.rotate!, types: %i[string string]
          end
        end

        def supplier_names(supplier_details)
          supplier_name_headings = { names: [], duns: [] }

          supplier_details.each do |supplier_detail|
            supplier_name = supplier_detail[0]
            supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

            supplier_name_headings[:names] << supplier_name
            supplier_name_headings[:duns] << supplier_duns
          end

          supplier_name_headings
        end
      end

      class SupplierLot1File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_1
        OUTPUT_PATH = './tmp/test_supplier_lot_1_service_offerings_file.xlsx'.freeze
        SHEETS = ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Administrative and Public Law', 'Non-Complex Finance and Investment', 'Contracts', 'Competition Law', 'Corporate Law', 'Data Protection and Information Law', 'Employment', 'Information Technology ', 'Infrastructure', 'Intellectual Property', 'Litigation and Dispute Resolution', 'Partnerships', 'Pensions', 'Public Procurement', 'Property, Real Estate and Construction', 'Energy, Natural Resources and Climate Change', 'Retained EU Law and EU Law', 'Planning', 'Projects', 'Restructuring and Insolvency', 'Education Law', 'Children and Vulnerable Adults', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Health, Healthcare and Social Care', 'Life Sciences', 'Telecommunications', 'International Trade, Investment and Regulation', 'Public International Law', 'Charities Law', 'Health and Safety', 'Licensing Law', 'Transport Law (excluding Rail)', 'Tax', 'Outsourcing / Insourcing', 'Islamic Finance / Sukuk', 'Media Law', 'Immigration', 'Public Inquests and Inquiries ', 'Mental Health Law'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '1.1', '1.2', '1.3', '1.4', '1.5', '1.6', '1.7', '1.8', '1.9', '1.10', '1.11', '1.12', '1.13', '1.14', '1.15', '1.16', '1.17', '1.18', '1.19', '1.20', '1.21', '1.22', '1.23', '1.24', '1.25', '1.26', '1.27', '1.28', '1.29', '1.30', '1.31', '1.32', '1.33', '1.34', '1.35', '1.36', '1.37', '1.38', '1.39', '1.40'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot2File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_2
        OUTPUT_PATH = './tmp/test_supplier_lot_2_service_offerings_file.xlsx'.freeze
        SHEETS = ['Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Property and Construction ', 'Social Housing', 'Child Law', 'Court of Protection', 'Education Law', 'Debt Recovery', 'Planning and Environment', 'Licensing', 'Pensions', 'Litigation / Dispute Resolution', 'Intellectual Property', 'Employment', 'Healthcare', 'Primary Care', 'Mental Health Law'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '2.1', '2.2', '2.3', '2.4', '2.5', '2.6', '2.7', '2.8', '2.9', '2.10', '2.11', '2.12', '2.13', '2.14', '2.15'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot3File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_3
        OUTPUT_PATH = './tmp/test_supplier_lot_3_service_offerings_file.xlsx'.freeze
        SHEETS = ['All regions'].freeze
        HEADERS_1 = ['', 'Service name', 'Transport (Rail)'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '3.1'].freeze
        BASE_SELECTION = ['x', 'x', 'x'].freeze
      end
    end
  end
end
