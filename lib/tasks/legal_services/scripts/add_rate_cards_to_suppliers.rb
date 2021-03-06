require 'roo'
require 'json'

# rubocop:disable Metrics/AbcSize

def add_rate_cards_to_suppliers
  suppliers = JSON.parse(File.read(get_ls_output_file_path('suppliers_with_all_services.json')))
  suppliers.each { |supplier| supplier['rate_cards'] = [] }
  rate_cards_workbook = Roo::Spreadsheet.open(rate_cards_file_path, extension: :xlsx)
  lot_numbers = ['1', '2a', '2b', '2c', '3', '4']

  (0..5).each do |sheet_number|
    sheet = rate_cards_workbook.sheet(sheet_number)

    (3..sheet.last_row).each do |row_number|
      row = sheet.row(row_number)
      supplier_duns = extract_duns(row.first)
      supplier = suppliers.find { |s| s['duns'] == supplier_duns }
      rate_card = {}
      rate_card['lot'] = lot_numbers[sheet_number]
      rate_card['managing'] = {}
      rate_card['managing']['hourly'] = convert_price_to_pence row[1]
      rate_card['managing']['daily'] = convert_price_to_pence row[2]
      rate_card['managing']['monthly'] = convert_price_to_pence row[3]
      rate_card['senior'] = {}
      rate_card['senior']['hourly'] = convert_price_to_pence row[4]
      rate_card['senior']['daily'] = convert_price_to_pence row[5]
      rate_card['senior']['monthly'] = convert_price_to_pence row[6]
      rate_card['solicitor'] = {}
      rate_card['solicitor']['hourly'] = convert_price_to_pence row[7]
      rate_card['solicitor']['daily'] = convert_price_to_pence row[8]
      rate_card['solicitor']['monthly'] = convert_price_to_pence row[9]
      rate_card['junior'] = {}
      rate_card['junior']['hourly'] = convert_price_to_pence row[10]
      rate_card['junior']['daily'] = convert_price_to_pence row[11]
      rate_card['junior']['monthly'] = convert_price_to_pence row[12]

      unless sheet_number.zero?
        rate_card['trainee'] = {}
        rate_card['trainee']['hourly'] = convert_price_to_pence row[13]
        rate_card['trainee']['daily'] = convert_price_to_pence row[14]
        rate_card['trainee']['monthly'] = convert_price_to_pence row[15]
      end

      supplier['rate_cards'] << rate_card
    end
  end

  write_ls_output_file('data.json', suppliers)
end

def extract_duns(supplier_name)
  supplier_name.split('[')[1].split(']')[0].to_i
end

def convert_price_to_pence(price)
  (price * 100).to_i
end

def rate_cards_file_path
  'storage/legal_services/current_data/input/rate_cards.xlsx'
end

# rubocop:enable Metrics/AbcSize
