module ManagementConsultancy
  module RM6187
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

      SHEETS = ['MCF3'].freeze
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
        options[:headers] ||= [HEADERS] * options[:sheets].count

        super
      end

      def build
        @sheets.zip(@headers).each do |sheet_name, header_row|
          add_rate_card_sheet(sheet_name, header_row)
        end
      end

      OUTPUT_PATH = './tmp/test_supplier_rate_cards_file.xlsx'.freeze

      SHEETS = ['MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'].freeze
      HEADERS = ['Supplier', 'Max day rate: Junior Consultant', 'Max day rate: Standard Consultant', 'Max day rate: Senior Consultant', 'Max day rate: Principal Consultant', 'Max day rate: Ma]naging Consultant', 'Max day rate: Director Consultant', 'Contact: Name', 'Contact: Email address', 'Contact: Phone number'].freeze

      private

      def add_rate_card_sheet(sheet_name, header_row)
        @package.workbook.add_worksheet(name: sheet_name) do |sheet|
          sheet.add_row header_row
          next if @empty

          SUPPLIERS.each do |supplier_detail|
            supplier_name = supplier_detail[0]
            supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

            sheet.add_row [supplier_heading_name(supplier_name, supplier_duns), 400, 800, 1200, 1600, 2000, 2400, supplier_name.split.first.capitalize, supplier_detail[1], supplier_detail[2]]
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

      SHEETS = ['MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'].freeze

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
        ManagementConsultancy::RM6187::Journey::ChooseServices.new(lot_id: "RM6187.#{lot_number.split('.')[1]}").lot_services.map { |service| "#{service.name} [#{lot_number}.#{service.number}]" }
      end

      private

      SHEET_NAMES_TO_LOT = { 'MCF3 Lot 1' => 'MCF3.1', 'MCF3 Lot 2' => 'MCF3.2', 'MCF3 Lot 3' => 'MCF3.3', 'MCF3 Lot 4' => 'MCF3.4', 'MCF3 Lot 5' => 'MCF3.5', 'MCF3 Lot 6' => 'MCF3.6', 'MCF3 Lot 7' => 'MCF3.7', 'MCF3 Lot 8' => 'MCF3.8', 'MCF3 Lot 9' => 'MCF3.9' }.freeze

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
