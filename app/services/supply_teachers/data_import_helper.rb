# rubocop:disable Metrics/ModuleLength
module SupplyTeachers::DataImportHelper
  def read_spreadsheet(file)
    workbook = Roo::Spreadsheet.open(current_file(file).path, extension: :xlsx)

    yield(workbook)

    workbook.close
  end

  def read_csv(file)
    csv = CSV.open(current_file(file).path, headers: true)

    yield(csv)

    csv.close
  end

  def current_file(file)
    tmpfile = Tempfile.create
    tmpfile.binmode
    tmpfile.write file.download
    tmpfile.close

    tmpfile
  end

  def accredited_suppliers
    @accredited_suppliers ||= find_accredited_suppliers
  end

  def find_accredited_suppliers
    suppliers = extract_suppliers
    accredited_supplier_names = accredited_suppliers_hashes.map(&:values).flatten

    suppliers.select do |supplier|
      accredited_supplier_names.include?(supplier[:'accreditation supplier name'])
    end
  end

  def extract_suppliers
    suppliers = []

    read_csv(@current_data.supplier_lookup) do |csv|
      csv.each do |row|
        suppliers << row.to_h.transform_keys!(&:to_sym)
      end
    end

    suppliers
  end

  def accredited_suppliers_hashes
    lot_1_accreditation = {}
    lot_2_accreditation = {}
    lot_3_accreditation = {}

    read_spreadsheet(@current_data.current_accredited_suppliers) do |accredited_suppliers_workbook|
      lot_1_accreditation_sheet = accredited_suppliers_workbook.sheet('Lot 1 - Preferred Supplier List')
      lot_1_accreditation = lot_1_accreditation_sheet.parse(header_search: ['Supplier Name - Accreditation Held'])

      lot_2_accreditation_sheet = accredited_suppliers_workbook.sheet('Lot 2 - Master Vendor MSP')
      lot_2_accreditation = lot_2_accreditation_sheet.parse(header_search: ['Supplier Name - Accreditation Held'])

      lot_3_accreditation_sheet = accredited_suppliers_workbook.sheet('Lot 3 - Neutral Vendor MSP')
      lot_3_accreditation = lot_3_accreditation_sheet.parse(header_search: ['Supplier Name'])
    end

    lot_1_accreditation + lot_2_accreditation + lot_3_accreditation
  end

  def remap_headers(row, header_map)
    r = row.map do |k, v|
      [header_map[k], v]
    end
    r.to_h
  end

  def supplier_accredited?(id)
    return false if id.blank?

    accredited_suppliers.select { |supplier| supplier.value?(id) }.any?
  end

  def strip_fields(row)
    row.transform_values { |v| v.is_a?(String) ? v.strip : v }
  end

  def nest(row, key)
    supplier_name = row[:supplier_name]
    other_records = row.reject { |k, _v| k == :supplier_name }
    { :supplier_name => supplier_name, key => [other_records] }
  end

  def subhead?(row)
    row[:number] =~ /Category Line/ || row[:number].nil?
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def symbolize_job_types(row, spreadsheet)
    job_type = case row[:job_type]
               when /Qualified.*Non-Special/m
                 :qt
               when /Qualified.*Special/m
                 :qt_sen
               when /Unqualified.*Non-Special/m
                 :uqt
               when /Unqualified.*Special/m
                 :uqt_sen
               when /Support.*Non-Special/m
                 :support
               when /Support.*Special/m
                 :support_sen
               when /Senior/m
                 :senior
               when /Clerical/m
                 :admin
               when /Nominated/m
                 :nominated
               when /Fixed Term/m
                 :fixed_term
               else
                 @errors << "#{row[:supplier_name]}: Unknown job type in '#{spreadsheet}.xlsx': #{row[:job_type].inspect}" if supplier_accredited?(row[:supplier_name])
                 :unknown
               end
    row.merge(job_type: job_type)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def remove_unused_keys(row)
    row.select { |key, _value| %i[supplier_name line_no job_type term fee].include? key }
  end

  def invalid_fee?(row)
    !row[:fee].is_a?(Float)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def collate(records)
    suppliers = records.map { |p| p[:supplier_name] }.uniq
    suppliers.map do |supplier|
      base_record = { supplier_name: supplier }
      supplier_records = records.select { |p| p[:supplier_name] == supplier }
      supplier_records.each do |rec|
        rec.each do |k, v|
          next if k == :supplier_name

          base_record[k] = [] unless base_record.key?(k)
          base_record[k] += v
        end
      end
      base_record
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
# rubocop:enable Metrics/ModuleLength
