require 'roo'
require 'json'

def add_rate_cards_to_suppliers
  suppliers = JSON.parse(File.read(get_mc_output_file_path('suppliers_with_service_offerings_and_regional_availability.json')))
  suppliers.each { |supplier| supplier['rate_cards'] = [] }

  rate_cards_workbook = Roo::Spreadsheet.open(rate_cards_workbook_filepath, extension: :xlsx)

  sheet_names = {
    'MCF Lot 2' => 'MCF1.2',
    'MCF Lot 3' => 'MCF1.3',
    'MCF Lot 4' => 'MCF1.4',
    'MCF Lot 5' => 'MCF1.5',
    'MCF Lot 6' => 'MCF1.6',
    'MCF Lot 7' => 'MCF1.7',
    'MCF Lot 8' => 'MCF1.8',
    'MCF2 Lot 1' => 'MCF2.1',
    'MCF2 Lot 2' => 'MCF2.2',
    'MCF2 Lot 3' => 'MCF2.3',
    'MCF2 Lot 4' => 'MCF2.4',
    'MCF3 Lot 1' => 'MCF3.1',
    'MCF3 Lot 2' => 'MCF3.2',
    'MCF3 Lot 3' => 'MCF3.3',
    'MCF3 Lot 4' => 'MCF3.4',
    'MCF3 Lot 5' => 'MCF3.5',
    'MCF3 Lot 6' => 'MCF3.6',
    'MCF3 Lot 7' => 'MCF3.7',
    'MCF3 Lot 8' => 'MCF3.8',
    'MCF3 Lot 9' => 'MCF3.9'
  }

  (0..19).each do |sheet_number|
    sheet = rate_cards_workbook.sheet(sheet_number)
    lot_number = sheet_names[sheet.default_sheet]

    (2..sheet.last_row).each do |row_number|
      row = sheet.row(row_number)
      supplier_duns = extract_duns(row.first)
      supplier = suppliers.find { |s| s['duns'] == supplier_duns }
      rate_card = {}
      rate_card['lot'] = lot_number
      rate_card['junior_rate_in_pence'] = convert_price(row[1])
      rate_card['standard_rate_in_pence'] = convert_price(row[2])
      rate_card['senior_rate_in_pence'] = convert_price(row[3])
      rate_card['principal_rate_in_pence'] = convert_price(row[4])
      rate_card['managing_rate_in_pence'] = convert_price(row[5])
      rate_card['director_rate_in_pence'] = convert_price(row[6])
      rate_card['contact_name'] = row[7]
      rate_card['email'] = row[8]
      rate_card['telephone_number'] = row[9]

      supplier['rate_cards'] << rate_card if supplier
    end
  end

  write_output_file('data.json', suppliers)
end

def convert_price(price)
  price.to_s.gsub(',', '').to_i * 100
end

def extract_duns(supplier_name)
  supplier_name.split('[')[1].split(']')[0].to_i
end

def rate_cards_workbook_filepath
  'storage/management_consultancy/current_data/input/rate_cards.xlsx'
end
