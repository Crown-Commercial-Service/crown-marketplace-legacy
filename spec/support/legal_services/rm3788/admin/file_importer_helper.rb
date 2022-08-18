module LegalServices
  module RM3788
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

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            headers = self::HEADERS
            headers += ['Extra'] if sheets_with_extra_headers.include? sheet
            headers
          end
        end

        SUPPLIERS_LOT_1 = [
          ['REX LTD', 'rex@xenoblade.com', '0202 123 4567', 'www.rex.com', 'Argentum AA3 1XC', 'Yes', '123456789'],
          ['NIA CORP', 'nia@xenoblade.com', '0203 234 5678', 'www.nia.com', 'Gromott AA3 2XC', 'No', '234567891'],
          ['TORA LTD', 'tora@xenoblade.com', '0204 345 6789', 'www.tora.com', 'Torigoth AA3 3XC', 'Yes', '345678912']
        ].freeze

        SUPPLIERS_LOT_2 = [
          ['TORA LTD', 'tora@xenoblade.com', '0204 345 6789', 'www.tora.com', 'Torigoth AA3 3XC', 'Yes', '345678912'],
          ['VANDHAM EXEC CORP', 'vandham@xenoblade.com', '0205 456 7890', 'www.vandham.com', 'Garfont AA3 4XC', 'No', '456789123'],
          ['MORAG JEWEL LTD', 'morag@xenoblade.com', '0204 567 8901', 'www.morag.com', 'Mor Ardain AA3 5XC', 'Yes', '567891234']
        ].freeze

        SUPPLIERS_LOT_3 = [
          ['MORAG JEWEL LTD', 'morag@xenoblade.com', '0204 567 8901', 'www.morag.com', 'Mor Ardain AA3 5XC', 'Yes', '567891234'],
          ['ZEKE VON GEMBU CORP', 'zeke@xenoblade.com', '0205 678 9012', 'www.zeke.com', 'Tantal AA3 6XC', 'No', '678912345'],
          ['JIN CORP', 'jin@xenoblade.com', '0206 789 0123', 'www.jin.com', 'Torna AA3 7XC', 'Yes', '789123456']
        ].freeze

        SUPPLIERS_LOT_4 = [
          ['REX LTD', 'rex@xenoblade.com', '0202 123 4567', 'www.rex.com', 'Argentum AA3 1XC', 'Yes', '123456789'],
          ['JIN CORP', 'jin@xenoblade.com', '0206 789 0123', 'www.jin.com', 'Torna AA3 7XC', 'Yes', '789123456'],
          ['MALOS LTD', 'malos@xenoblade.com', '0207 890 1234', 'www.malos.com', 'Elysium AA3 8XC', 'No', '891234567']
        ].freeze
      end

      class SupplierDetailsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= [HEADERS] * options[:sheets].count

          super(**options)
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_supplier_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_details_file.xlsx'.freeze

        SHEETS = ['All Suppliers'].freeze
        HEADERS = ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4: Prospectus Link', 'About the supplier'].freeze

        private

        def add_supplier_sheet(sheet_name, header_row)
          supplier_details = (SUPPLIERS_LOT_1 + SUPPLIERS_LOT_2 + SUPPLIERS_LOT_3 + SUPPLIERS_LOT_4).uniq

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
          options[:headers] ||= [HEADERS_1] + [HEADERS] * (options[:sheets].count - 1)

          super(**options)
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_rate_card_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_rate_cards_file.xlsx'.freeze

        SHEETS = ['Lot 1', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3', 'Lot 4'].freeze
        HEADERS_1 = ['Supplier', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly'].freeze
        HEADERS = ['Supplier', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly', 'Hourly', 'Daily', 'Monthly'].freeze
        PRICES_1 = [190, 1330, 22800, 185, 1295, 22200, 175, 1225, 21000, 160, 1120, 19200].freeze
        PRICES = [190, 1330, 22800, 185, 1295, 22200, 175, 1225, 21000, 160, 1120, 19200, 100, 700, 14000].freeze

        private

        def add_rate_card_sheet(sheet_name, header_row)
          supplier_details = suppliers(sheet_name)

          sheet_prices = prices(sheet_name)

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row
            sheet.add_row header_row
            next if @empty

            supplier_details.each do |supplier_detail|
              supplier_name = supplier_detail[0]
              supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

              sheet.add_row [supplier_heading_name(supplier_name, supplier_duns)] + sheet_prices
            end
          end
        end

        def suppliers(sheet_name)
          if sheet_name.include? '4'
            SUPPLIERS_LOT_4
          elsif sheet_name.include? '3'
            SUPPLIERS_LOT_3
          elsif sheet_name.include? '2'
            SUPPLIERS_LOT_2
          else
            SUPPLIERS_LOT_1
          end
        end

        def prices(sheet_name)
          if sheet_name == 'Lot 1'
            PRICES_1
          else
            PRICES
          end
        end
      end

      class SupplierLotFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= self.class::SHEETS
          options[:headers] ||= [self.class::HEADERS] * options[:sheets].count

          super(**options)
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_column|
            add_service_offerings_sheet(sheet_name, header_column)
          end
        end

        private

        def add_service_offerings_sheet(sheet_name, header_column)
          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            @empty ? add_blank_sheet(sheet, header_column) : add_sheet_with_data(sheet, header_column)
          end
        end

        def add_blank_sheet(sheet, header_column)
          sheet.add_row [nil]
          header_column.each { |service| sheet.add_row [service] }
        end

        def add_sheet_with_data(sheet, header_column)
          selection = ['x', nil, 'x']
          supplier_name_headings = supplier_names(self.class::SUPPLIERS)

          sheet.add_row [nil] + supplier_name_headings

          header_column.each do |service|
            sheet.add_row [service] + selection.rotate!
          end
        end

        def supplier_names(supplier_details)
          supplier_details.map do |supplier_detail|
            supplier_name = supplier_detail[0]
            supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

            supplier_heading_name(supplier_name, supplier_duns)
          end
        end
      end

      class SupplierLot1File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_1
        OUTPUT_PATH = './tmp/test_supplier_lot_1_service_offerings_file.xlsx'.freeze
        SHEETS = ['Full UK Coverage', 'North East England (NUTS C)', 'North West England (NUTS D)', 'Yorkshire & Humberside (NUTS E)', 'East Midlands (NUTS F)', 'West Midlands (NUTS G)', 'East of England (NUTS H)', 'Greater London (NUTS I)', 'South East England (NUTS J)', 'South West England (NUTS K)', 'Wales (NUTS L)', 'Scotland (NUTS M)', 'Northern Ireland (NUTS N)'].freeze
        HEADERS = ['Property and construction [WPSLS.1.1]', 'Social housing [WPSLS.1.2]', 'Child law [WPSLS.1.3]', 'Court of protection [WPSLS.1.4]', 'Education [WPSLS.1.5]', 'Debt recovery [WPSLS.1.6]', 'Planning and environment [WPSLS.1.7]', 'Licensing [WPSLS.1.8]', 'Pensions [WPSLS.1.9]', 'Litigation / dispute resolution [WPSLS.1.10]', 'Intellectual property [WPSLS.1.11]', 'Employment [WPSLS.1.12]', 'Healthcare [WPSLS.1.13]', 'Primary care [WPSLS.1.14]'].freeze
      end

      class SupplierLot2File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_2
        OUTPUT_PATH = './tmp/test_supplier_lot_2_service_offerings_file.xlsx'.freeze
        SHEETS = ['Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland'].freeze
        HEADERS = ['Administrative and public law [WPSLS.2c.1]', 'Banking and Finance [WPSLS.2c.2]', 'Contracts [WPSLS.2c.3]', 'Competition law [WPSLS.2c.4]', 'Corporate and M&A [WPSLS.2c.5]', 'Data protection and information law [WPSLS.2c.6]', 'Employment [WPSLS.2c.7]', 'Information technology [WPSLS.2c.8]', 'Infrastructure [WPSLS.2c.9]', 'Intellectual property [WPSLS.2c.10]', 'Litigation and dispute resolution [WPSLS.2c.11]', 'Outsourcing / insourcing [WPSLS.2c.12]', 'Partnerships [WPSLS.2c.13]', 'Pensions [WPSLS.2c.14]', 'Public procurement [WPSLS.2c.15]', 'Property, real estate & construction [WPSLS.2c.16]', 'Tax [WPSLS.2c.17]', 'EU [WPSLS.2c.18]', 'Planning [WPSLS.2c.19]', 'Projects [WPSLS.2c.20]', 'Restructuring and insolvency [WPSLS.2c.21]', 'Education law [WPSLS.2c.22]', 'Child law [WPSLS.2c.23]', 'Energy and natural resources [WPSLS.2c.24]', 'Food, rural and environmental affairs [WPSLS.2c.25]', 'Franchise law [WPSLS.2c.26]', 'Health and healthcare [WPSLS.2c.27]', 'Life sciences [WPSLS.2c.28]', 'Telecommunications [WPSLS.2c.29]', 'The law of international trade, investment and regulation [WPSLS.2c.30]', 'Public international law [WPSLS.2c.31]', 'Charities law [WPSLS.2c.32]', 'Health & safety law [WPSLS.2c.33]', 'Licensing law [WPSLS.2c.34]', 'Transport law (excluding rail) [WPSLS.2c.35]'].freeze
      end

      class SupplierLot3File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_3
        OUTPUT_PATH = './tmp/test_supplier_lot_3_service_offerings_file.xlsx'.freeze
        SHEETS = ['All regions'].freeze
        HEADERS = ['All Services [WPSLS.3.1]'].freeze
      end

      class SupplierLot4File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_4
        OUTPUT_PATH = './tmp/test_supplier_lot_4_service_offerings_file.xlsx'.freeze
        SHEETS = ['All regions'].freeze
        HEADERS = ['All Services [WPSLS.4.1]'].freeze
      end
    end
  end
end
