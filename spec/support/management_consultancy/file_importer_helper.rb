module ManagementConsultancy
  class FileImporterHelper
    def initialize(**options)
      @package = Axlsx::Package.new
      @sheets = options[:sheets]
      @headers = options[:headers]
      @supplier_duns = options[:supplier_duns] || {}
      @empty = options[:empty] || false
    end

    def suppliers(lot_number)
      if lot_number.start_with? 'MCF3'
        SUPPLIERS_MCF3
      elsif lot_number.start_with? 'MCF2'
        SUPPLIERS_MCF2
      else
        SUPPLIERS_MCF1
      end
    end

    def supplier_heading_name(name, duns)
      "#{name} [#{duns}]"
    end

    def write
      File.write(self.class::OUTPUT_PATH, @package.to_stream.read)
    end

    def self.sheets_with_extra_headers(sheets_with_extra_headers)
      self::SHEETS.map do |sheet|
        headers = self::HEADERS
        headers += ['Extra'] if sheets_with_extra_headers.include? sheet
        headers
      end
    end

    SUPPLIERS_MCF1 = [
      ['REX LTD', 'rex@xenoblade.com', '0202 123 4567', 'www.rex.com', 'Argentum AA3 1XC', 'Yes', '123456789'],
      ['NIA CORP', 'nia@xenoblade.com', '0203 234 5678', 'www.nia.com', 'Gromott AA3 2XC', 'No', '234567891'],
      ['TORA LTD', 'tora@xenoblade.com', '0204 345 6789', 'www.tora.com', 'Torigoth AA3 3XC', 'Yes', '345678912']
    ].freeze

    SUPPLIERS_MCF2 = [
      ['TORA LTD', 'tora@xenoblade.com', '0204 345 6789', 'www.tora.com', 'Torigoth AA3 3XC', 'Yes', '345678912'],
      ['VANDHAM EXEC CORP', 'vandham@xenoblade.com', '0205 456 7890', 'www.vandham.com', 'Garfont AA3 4XC', 'No', '456789123'],
      ['MORAG JEWEL LTD', 'morag@xenoblade.com', '0204 567 8901', 'www.morag.com', 'Mor Ardain AA3 5XC', 'Yes', '567891234']
    ].freeze

    SUPPLIERS_MCF3 = [
      ['REX LTD', 'rex@xenoblade.com', '0202 123 4567', 'www.rex.com', 'Argentum AA3 1XC', 'Yes', '123456789'],
      ['MORAG JEWEL LTD', 'morag@xenoblade.com', '0204 567 8901', 'www.morag.com', 'Mor Ardain AA3 5XC', 'Yes', '567891234'],
      ['ZEKE VON GEMBU CORP', 'zeke@xenoblade.com', '0205 678 9012', 'www.zeke.com', 'Tantal AA3 6XC', 'No', '678912345']
    ].freeze
  end

  class SupplierDetailsFile < FileImporterHelper
    def initialize(**options)
      options[:sheets] ||= self.class::SHEETS
      options[:headers] ||= [HEADERS] * options[:sheets].count

      super(**options)
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
      supplier_details = suppliers(sheet_name)

      @package.workbook.add_worksheet(name: sheet_name) do |sheet|
        sheet.add_row header_row
        next if @empty

        supplier_details.each do |supplier_detail|
          sheet.add_row supplier_detail
        end
      end
    end
  end

  class Legacy::SupplierDetailsFile < SupplierDetailsFile
    SHEETS = ['MCF', 'MCF2', 'MCF3'].freeze
  end

  class SupplierRateCardsFile < FileImporterHelper
    def initialize(**options)
      options[:sheets] ||= self.class::SHEETS
      options[:headers] ||= [HEADERS] * options[:sheets].count

      super(**options)
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
      supplier_details = suppliers(sheet_name)

      @package.workbook.add_worksheet(name: sheet_name) do |sheet|
        sheet.add_row header_row
        next if @empty

        supplier_details.each do |supplier_detail|
          supplier_name = supplier_detail[0]
          supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

          sheet.add_row [supplier_heading_name(supplier_name, supplier_duns), 400, 800, 1200, 1600, 2000, 2400, supplier_name.split.first.capitalize, supplier_detail[1], supplier_detail[2]]
        end
      end
    end
  end

  class Legacy::SupplierRateCardsFile < SupplierRateCardsFile
    SHEETS = ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'].freeze
  end

  class Legacy::SupplierRegionalOfferingsFile < FileImporterHelper
    def initialize(**options)
      options[:sheets] ||= SHEETS
      options[:headers] ||= [HEADERS] * options[:sheets].count

      super(**options)
    end

    def build
      @sheets.zip(@headers).each do |sheet_name, header_row|
        add_regional_offerings_sheet(sheet_name, header_row)
      end
    end

    OUTPUT_PATH = './tmp/test_supplier_regional_offerings_file.xlsx'.freeze

    SHEETS = ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4'].freeze
    HEADERS = ['Supplier', 'North East sub regions - All (UKC)', 'Tees Valley & Durham (UKC1)', 'Northumberland and Tyne & Wear (UKC2)', 'North West sub regions - All  (UKD)', 'Cumbria (UKD1)', 'Greater Manchester (UKD3)', 'Lancashire (UKD4)', 'Cheshire (UKD6)', 'Merseyside (UKD7)', 'Yorkshire & The Humber sub regions All (UKE)', 'East Riding & North Lincolnshire (UKE1)', 'North Yorkshire (UKE2)', 'South Yorkshire (UKE3)', 'West Yorkshire (UKE4)', 'East Midlands sub regions - All (UKF)', 'Derbyshire & Nottinghamshire (UKF1)', 'Leicestershire, Rutland & Northamptonshire (UKF2)', 'Lincolnshire (UKF3)', 'West Midlands sub regions - All (UKG)', 'Herefordshire Worcestershire & Warwickshire (UKG1)', 'Shropshire & Staffordshire (UKG2)', 'West Midlands (UKG3)', 'East of England sub regions - All (UKH)', 'East Anglia (UKH1)', 'Bedfordshire & Hertfordshire (UKH2)', 'Essex (UKH3)', 'London sub regions - All (UKI)', 'London - Inner London West (UKI3)', 'London - Inner London East (UKI4)', 'London - Outer London East & North East (UKI5)', 'London - Outer London South (UKI6)', 'London - Outer London West & North West (UKI7)', 'South East sub regions - All (UKJ)', 'Berkshire, Buckinghamshire & Oxfordshire (UKJ1)', 'Surrey, East Sussex & West Sussex (UKJ2)', 'Hampshire & Isle of Wight (UKJ3)', 'Kent (UKJ4)', 'South West England - All (UKK)', 'Gloucestershire, Wiltshire & Bristol / Bath area (UKK1)', 'Dorset & Somerset (UKK2)', 'Cornwall & Isles of Scilly (UKK3)', 'Devon (UKK4)', 'Wales sub regions - All (UKL)', 'Wales - West Wales & The Valleys (UKL1)', 'Wales - East Wales (UKL2)', 'Scotland sub regions - All (UKM)', 'Scotland - Eastern Scotland (UKM2)', 'Scotland - South Western Scotland (UKM3)', 'Scotland - North Eastern Scotland (UKM5)', 'Scotland - Highlands & Islands (UKM6)', 'Northern Ireland (UKN0)'].freeze

    private

    def add_regional_offerings_sheet(sheet_name, header_row)
      supplier_details = suppliers(sheet_name)

      @package.workbook.add_worksheet(name: sheet_name) do |sheet|
        sheet.add_row header_row
        next if @empty

        supplier_details.each do |supplier_detail|
          supplier_name = supplier_detail[0]

          sheet.add_row [supplier_heading_name(supplier_name, supplier_detail[6])] + SUPPLIER_REGIONS[supplier_name.to_sym]
        end
      end
    end

    SUPPLIER_REGIONS = {
      'REX LTD': [nil, 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', nil, 'x', nil, 'x', 'x', 'x', 'x', nil, nil, nil, nil, 'x', nil, 'x', nil, 'x', 'x', 'x', 'x', nil, 'x'],
      'NIA CORP': ['x', 'x', nil, 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x', nil, nil, 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x', nil, nil, nil, 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x', 'x', 'x', 'x', nil, nil, 'x', 'x', 'x', 'x', nil, 'x', 'x', nil, 'x', 'x', 'x', 'x'],
      'TORA LTD': ['x', 'x', nil, 'x', nil, 'x', 'x', 'x', nil, 'x', 'x', 'x', nil, 'x', 'x', 'x', 'x', nil, 'x', 'x', 'x', 'x', nil, nil, nil, 'x', nil, 'x', 'x', 'x', nil, 'x', nil, 'x', 'x', 'x', nil, 'x', nil, 'x', 'x', 'x', nil, 'x', nil, 'x', 'x', 'x', nil, 'x', 'x'],
      'VANDHAM EXEC CORP': [nil, 'x', 'x', nil, 'x', 'x', 'x', 'x', nil, 'x', 'x', nil, 'x', 'x', 'x', 'x', nil, 'x', nil, 'x', nil, nil, 'x', nil, 'x', nil, 'x', nil, nil, 'x', 'x', nil, 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', nil, 'x', 'x', 'x', 'x', nil, nil, nil, 'x'],
      'MORAG JEWEL LTD': ['x', nil, 'x', nil, nil, 'x', 'x', 'x', 'x', 'x', nil, 'x', nil, 'x', 'x', 'x', 'x', 'x', 'x', nil, nil, 'x', nil, 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', nil, 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', nil, 'x', 'x']
    }.freeze
  end

  class SupplierServiceOfferingsFile < FileImporterHelper
    def initialize(**options)
      options[:sheets] ||= self.class::SHEETS
      options[:headers] ||= self.class.create_headers(options[:sheets])

      super(**options)
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
      if lot_number.start_with? 'MCF2'
        rows = ManagementConsultancy::Journey::ChooseServices.new.services_for_lot(lot_number).map { |service| get_subservice_column(service) }.flatten
        rows += ["Empty [#{lot_number}.0]"] unless lot_number == 'MCF2.3'
        rows
      else
        ManagementConsultancy::Journey::ChooseServices.new.services_for_lot(lot_number).map { |service| "#{service.name} [#{service.code}]" }
      end
    end

    def self.get_subservice_column(service)
      if service.subservices.present?
        ["#{service.name} [#{service.code}.0]"] + service.subservices.map { |sub_service| "#{sub_service.name} [#{sub_service.code}]" }
      else
        "#{service.name} [#{service.code}]"
      end
    end

    private

    SHEET_NAMES_TO_LOT = { 'MCF3 Lot 1' => 'MCF3.1', 'MCF3 Lot 2' => 'MCF3.2', 'MCF3 Lot 3' => 'MCF3.3', 'MCF3 Lot 4' => 'MCF3.4', 'MCF3 Lot 5' => 'MCF3.5', 'MCF3 Lot 6' => 'MCF3.6', 'MCF3 Lot 7' => 'MCF3.7', 'MCF3 Lot 8' => 'MCF3.8', 'MCF3 Lot 9' => 'MCF3.9' }.freeze

    def add_service_offerings_sheet(sheet_name, header_column)
      supplier_details = suppliers(sheet_name)

      @package.workbook.add_worksheet(name: sheet_name) do |sheet|
        @empty ? add_blank_sheet(sheet, header_column) : add_sheet_with_data(sheet, header_column, supplier_details)
      end
    end

    def add_blank_sheet(sheet, header_column)
      sheet.add_row [nil]
      header_column.each { |service| sheet.add_row [service] }
    end

    def add_sheet_with_data(sheet, header_column, supplier_details)
      supplier_names = supplier_details.map do |supplier_detail|
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

  class Legacy::SupplierServiceOfferingsFile < SupplierServiceOfferingsFile
    SHEETS = ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'].freeze
    SHEET_NAMES_TO_LOT = { 'MCF Lot 2' => 'MCF1.2', 'MCF Lot 3' => 'MCF1.3', 'MCF Lot 4' => 'MCF1.4', 'MCF Lot 5' => 'MCF1.5', 'MCF Lot 6' => 'MCF1.6', 'MCF Lot 7' => 'MCF1.7', 'MCF Lot 8' => 'MCF1.8', 'MCF2 Lot 1' => 'MCF2.1', 'MCF2 Lot 2' => 'MCF2.2', 'MCF2 Lot 3' => 'MCF2.3', 'MCF2 Lot 4' => 'MCF2.4', 'MCF3 Lot 1' => 'MCF3.1', 'MCF3 Lot 2' => 'MCF3.2', 'MCF3 Lot 3' => 'MCF3.3', 'MCF3 Lot 4' => 'MCF3.4', 'MCF3 Lot 5' => 'MCF3.5', 'MCF3 Lot 6' => 'MCF3.6', 'MCF3 Lot 7' => 'MCF3.7', 'MCF3 Lot 8' => 'MCF3.8', 'MCF3 Lot 9' => 'MCF3.9' }.freeze
  end
end
