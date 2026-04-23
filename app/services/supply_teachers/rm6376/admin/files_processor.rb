class SupplyTeachers::RM6376::Admin::FilesProcessor < FilesProcessor
  def initialize(...)
    super
    configure_geocode
  end

  private

  def add_suppliers(suppliers_workbook)
    headers = {
      name: 'Supplier Name',
      trading_name: 'Supplier Trading Name',
      additional_identifier: 'Supplier Identifier',
      managed_service_provider_name: 'Managed service provider contact name',
      managed_service_provider_email: 'Managed service provider contact email',
      managed_service_provider_telephone: 'Managed service provider contact telephone',
      lot_1: 'Lot 1',
      lot_2: 'Lot 2',
      clean: true
    }

    @supplier_data = suppliers_workbook.sheet(0).parse(headers).map(&:stringify_keys!).map do |supplier|
      lot_ids = (1..2).map { |lot_number| supplier["lot_#{lot_number}"]&.downcase == 'x' ? "RM6376.#{lot_number}" : nil }.compact

      {
        id: SecureRandom.uuid,
        name: supplier['name'],
        additional_details: {
          trading_name: supplier['trading_name'],
          additional_identifier: supplier['additional_identifier'].to_s,
        },
        supplier_frameworks: [
          {
            framework_id: 'RM6376',
            enabled: true,
            supplier_framework_contact_detail: {
              additional_details: {
                managed_service_provider_name: supplier['managed_service_provider_name'],
                managed_service_provider_email: supplier['managed_service_provider_email'],
                managed_service_provider_telephone: supplier['managed_service_provider_telephone'],
              }
            },
            supplier_framework_lots_data: lot_ids.index_with do |_lot_id|
              {
                services: [],
                rates: [],
                branches: [],
                jurisdictions: []
              }
            end,
            supplier_framework_lots: []
          }
        ]
      }
    end
  end

  def add_branches(supplier_geographical_data_workbook)
    headers = {
      supplier_name: 'Supplier Name',
      additional_identifier: 'Supplier Identifier',
      name: 'Branch Name/No.',
      contact_name: 'Branch Contact name',
      address_line_1: 'Address 1',
      address_line_2: 'Address 2',
      town: 'Town',
      county: 'County',
      postcode: 'Post Code',
      contact_email: 'Branch Contact Name Email Address',
      telephone_number: 'Branch Telephone Number',
      region: 'Region',
      clean: true
    }

    supplier_geographical_data_workbook.sheet(0).parse(headers).map(&:symbolize_keys!).map { |row| sanitize_row(row) }.each do |geographical_data|
      supplier = get_supplier_by_additional_identifier(geographical_data[:additional_identifier].to_s)

      next unless supplier

      add_branch(supplier, geographical_data)
    end
  end

  def add_branch(supplier, geographical_data)
    geographical_data[:telephone_number] = fix_telephone(geographical_data[:telephone_number])
    geographical_data[:postcode] = normalize_postcode(geographical_data[:postcode])
    geographical_data[:lat], geographical_data[:lon] = geocode_branch(geographical_data[:postcode])

    supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]['RM6376.1']

    return if supplier_framework_lot.nil?

    supplier_framework_lot[:branches] << geographical_data.except(:supplier_name, :additional_identifier)
  end

  def sanitize_row(row)
    %i[convert_html_fields_to_text convert_float_fields_to_int strip_fields strip_punctuation_from_postcode strip_keys_with_null_or_empty_values].reduce(row) { |current_row, method| send(method, current_row) }
  end

  def convert_html_fields_to_text(row)
    row.transform_values { |v| v.is_a?(String) ? Capybara.string(v).text : v }
  end

  def convert_float_fields_to_int(row)
    row.transform_values { |v| v.is_a?(Float) ? v.to_i : v }
  end

  def strip_fields(row)
    row.transform_values { |v| v.is_a?(String) ? v.strip : v }
  end

  def strip_punctuation_from_postcode(row)
    row.merge(postcode: row[:postcode].gsub(/[^\w\s]/, ''))
  end

  def strip_keys_with_null_or_empty_values(row)
    row.reject { |_, v| v.nil? || v == '' }.to_h
  end

  def fix_telephone(telephone)
    case telephone
    when String
      telephone.gsub(/^#/, '')
    when Integer
      "0#{telephone}"
    when Float
      "0#{telephone.to_i}"
    end
  end

  def normalize_postcode(postcode_value)
    postcode = UKPostcode.parse(postcode_value)

    postcode.to_s if postcode.valid?
  end

  def geocode_branch(postcode)
    lat, lon = geocode(postcode)

    if lat && lon
      [lat, lon]
    else
      [nil, nil]
    end
  end

  def configure_geocode
    @geocoder_cache = {}

    if File.exist?(geocoder_cache_path)
      File.open(geocoder_cache_path) do |file|
        @geocoder_cache = YAML.safe_load(file.read)
      end
    else
      FileUtils.mkdir_p(geocoder_cache_path.dirname)
      FileUtils.touch(geocoder_cache_path)
    end

    Geocoder.configure(
      lookup: Rails.env.test? ? :test : :google,
      api_key: ENV.fetch('GOOGLE_GEOCODING_API_KEY', nil),
      units: :mi,
      distance: :spherical,
      cache: @geocoder_cache
    )
  end

  def geocode(postcode)
    Geocoder.coordinates(postcode, params: { region: 'uk' })
  end

  def geocoder_cache_path
    @geocoder_cache_path ||= Rails.root.join('storage', 'supply_teachers', 'current_data', '.geocoder-cache.yml')
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    LOT_NUMBERS.each.with_index do |lot_number, sheet_number|
      add_rates_from_sheet(rate_cards_workbook.sheet(sheet_number), lot_number)
    end
  end

  def add_rates_from_sheet(sheet, lot_number)
    (3..sheet.last_row).each do |row_number|
      row = sheet.row(row_number)
      supplier = get_supplier_by_additional_identifier(row.second.to_s)
      next unless supplier

      add_rates(supplier, row, lot_number)
    end
  end

  def add_rates(supplier, row, lot_number)
    lot_id = "RM6376.#{lot_number}"
    jurisdiction_id = 'GB'
    supplier_framework_lot = supplier[:supplier_frameworks][0][:supplier_framework_lots_data][lot_id]

    return if supplier_framework_lot.nil?

    supplier_framework_lot[:jurisdictions] << {
      jurisdiction_id:
    }

    row[2..].each.with_index(1) do |rate, index|
      rate = convert_rate(rate, index >= 9 ? :percentage : :pence)

      next if rate.zero?

      position_id = "#{lot_id}.#{index}"

      supplier_framework_lot[:rates] << {
        position_id:,
        rate:,
        jurisdiction_id:
      }
    end
  end

  def convert_rate(rate, rate_type)
    rate&.*(rate_type == :pence ? 100 : 10000).to_i
  end

  def convert_rate_to_percentage(rate)
    rate&.*(10000).to_i
  end

  LOT_NUMBERS = ['1', '2'].freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_geographical_data_file: :add_branches,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers,
  }.freeze
end
