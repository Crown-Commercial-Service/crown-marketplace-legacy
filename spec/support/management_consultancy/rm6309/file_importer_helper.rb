module ManagementConsultancy
  module RM6309
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

      SUPPLIERS = [
        ['REX LTD', 'rex@xenoblade.com', '0202 123 4567', 'www.rex.com', 'Argentum AA3 1XC', 'Yes', '123456789'],
        ['MORAG JEWEL LTD', 'morag@xenoblade.com', '0204 567 8901', 'www.morag.com', 'Mor Ardain AA3 5XC', 'Yes', '567891234'],
        ['ZEKE VON GEMBU CORP', 'zeke@xenoblade.com', '0205 678 9012', 'www.zeke.com', 'Tantal AA3 6XC', 'No', '678912345']
      ].freeze
    end

    class SupplierDetailsFile < FileImporterHelper
      def initialize(**options)
        options[:sheets] ||= self.class::SHEETS
        options[:headers] ||= [HEADERS] * options[:sheets].count

        super
      end

      def build
        @sheets.zip(@headers).each do |sheet_name, header_row|
          add_supplier_sheet(sheet_name, header_row)
        end
      end

      OUTPUT_PATH = './tmp/test_supplier_details_file.xlsx'.freeze

      SHEETS = ['MCF4'].freeze
      HEADERS = ['Supplier name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME?', 'DUNS Number'].freeze

      private

      def add_supplier_sheet(sheet_name, header_row)
        @package.workbook.add_worksheet(name: sheet_name) do |sheet|
          sheet.add_row header_row
          next if @empty

          SUPPLIERS.each do |supplier_detail|
            sheet.add_row supplier_detail
          end
        end
      end
    end

    class SupplierRateCardsFile < FileImporterHelper
      def initialize(**options)
        options[:sheets] ||= self.class::SHEETS
        options[:headers] ||= ([DEFAULT_HEADERS] * (options[:sheets].count - 1)) + [LOT_10_HEADERS]

        super
      end

      def build
        @sheets.zip(@headers).each do |sheet_name, header_row|
          add_rate_card_sheet(sheet_name, header_row)
        end
      end

      def self.sheets_with_extra_headers(sheets_with_extra_headers)
        self::SHEETS.map do |sheet|
          headers = sheet == 'MCF4 Lot 10' ? self::LOT_10_HEADERS : self::DEFAULT_HEADERS
          headers += ['Extra'] if sheets_with_extra_headers.include? sheet
          headers
        end
      end

      OUTPUT_PATH = './tmp/test_supplier_rate_cards_file.xlsx'.freeze

      SHEETS = ['MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9', 'MCF4 Lot 10'].freeze
      DEFAULT_HEADERS = ['Supplier', 'Max day rate: Junior Consultant (Advice)', 'Max day rate: Junior Consultant (Delivery)', 'Max day rate: Standard Consultant (Advice)', 'Max day rate: Standard Consultant (Delivery)', 'Max day rate: Senior Consultant (Advice)', 'Max day rate: Senior Consultant (Delivery)', 'Max day rate: Principal Consultant (Advice)', 'Max day rate: Principal Consultant (Delivery)', 'Max day rate: Managing Consultant (Advice)', 'Max day rate: Managing Consultant (Delivery)', 'Max day rate: Director Consultant (Advice)', 'Max day rate: Director Consultant (Delivery)', 'Contact: Name', 'Contact: Email address', 'Contact: Phone number'].freeze
      LOT_10_HEADERS = ['Supplier', 'Max day rate: Junior Consultant (Complex)', 'Max day rate: Junior Consultant (Non-Complex)', 'Max day rate: Standard Consultant (Complex)', 'Max day rate: Standard Consultant (Non-Complex)', 'Max day rate: Senior Consultant (Complex)', 'Max day rate: Senior Consultant (Non-Complex)', 'Max day rate: Principal Consultant (Complex)', 'Max day rate: Principal Consultant (Non-Complex)', 'Max day rate: Managing Consultant (Complex)', 'Max day rate: Managing Consultant (Non-Complex)', 'Max day rate: Director Consultant (Complex)', 'Max day rate: Director Consultant (Non-Complex)', 'Contact: Name', 'Contact: Email address', 'Contact: Phone number'].freeze

      private

      def add_rate_card_sheet(sheet_name, header_row)
        @package.workbook.add_worksheet(name: sheet_name) do |sheet|
          sheet.add_row header_row
          next if @empty

          SUPPLIERS.each do |supplier_detail|
            supplier_name = supplier_detail[0]
            supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

            sheet.add_row [supplier_heading_name(supplier_name, supplier_duns), 400, 450, 800, 850, 1200, 1250, 1600, 1650, 2000, 2050, 2400, 2450, supplier_name.split.first.capitalize, supplier_detail[1], supplier_detail[2]]
          end
        end
      end
    end

    class SupplierServiceOfferingsFile < FileImporterHelper
      def initialize(**options)
        options[:sheets] ||= self.class::SHEETS
        options[:headers] ||= self.class.create_headers(options[:sheets])

        super
      end

      def build
        @sheets.zip(@headers).each do |sheet_name, header_column|
          add_service_offerings_sheet(sheet_name, header_column)
        end
      end

      OUTPUT_PATH = './tmp/test_supplier_service_offerings_file.xlsx'.freeze

      SHEETS = ['MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9', 'MCF4 Lot 10'].freeze

      def self.create_headers(sheets)
        sheets.map { |sheet| get_services_column(self::SHEET_NAMES_TO_LOT[sheet].to_s) }
      end

      def self.headers_with_extra_service(sheets_with_extra_rows)
        self::SHEETS.map do |sheet|
          column = get_services_column(self::SHEET_NAMES_TO_LOT[sheet])
          column += ['Extra'] if sheets_with_extra_rows.include? sheet
          column
        end
      end

      def self.get_services_column(lot_number)
        ManagementConsultancy::RM6309::Journey::ChooseServices.new.services_for_lot(lot_number).map { |service| "#{service.name} [#{service.code}]" }
      end

      private

      SHEET_NAMES_TO_LOT = { 'MCF4 Lot 1' => 'MCF4.1', 'MCF4 Lot 2' => 'MCF4.2', 'MCF4 Lot 3' => 'MCF4.3', 'MCF4 Lot 4' => 'MCF4.4', 'MCF4 Lot 5' => 'MCF4.5', 'MCF4 Lot 6' => 'MCF4.6', 'MCF4 Lot 7' => 'MCF4.7', 'MCF4 Lot 8' => 'MCF4.8', 'MCF4 Lot 9' => 'MCF4.9', 'MCF4 Lot 10' => 'MCF4.10' }.freeze

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
        supplier_names = SUPPLIERS.map do |supplier_detail|
          supplier_name = supplier_detail[0]
          supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

          supplier_heading_name(supplier_name, supplier_duns)
        end

        sheet.add_row [nil] + supplier_names

        header_column.each do |service|
          if service.end_with? '.0]'
            sheet.add_row [service]
          else
            sheet.add_row [service, 'x', 'x', 'x']
          end
        end
      end
    end
  end
end
