module SupplyTeachers::DataImport::Helper
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

  def remap_headers(row, header_map)
    r = row.map do |k, v|
      [header_map[k], v]
    end
    r.to_h
  end

  def strip_fields(row)
    row.transform_values { |v| v.is_a?(String) ? v.strip : v }
  end

  def nest(row, key)
    supplier_name = row[:supplier_name]
    other_records = row.except(:supplier_name)
    { :supplier_name => supplier_name, key => [other_records] }
  end

  def collate(records)
    suppliers = records.pluck(:supplier_name).uniq
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

  def subhead?(row)
    row[:number].to_s =~ /Category Line/ || row[:number].nil?
  end

  def remove_unused_keys(row)
    row.slice(:supplier_name, :line_no, :job_type, :term, :fee)
  end

  def invalid_fee?(row)
    !row[:fee].is_a?(Float)
  end

  def supplier_accredited?(id)
    return false if id.blank?

    accredited_suppliers.any? { |supplier| supplier.value?(id) }
  end

  def accredited_suppliers
    @accredited_suppliers ||= begin
      suppliers = extract_suppliers

      suppliers.select do |supplier|
        accredited_supplier_names.include?(supplier[:'accreditation supplier name'])
      end
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

  def accredited_supplier_names
    @accredited_supplier_names ||= begin
      accredited_suppliers_names = []

      read_spreadsheet(@current_data.current_accredited_suppliers) do |accredited_suppliers_workbook|
        accredited_suppliers_names = accredited_suppliers_sheets.map do |sheet_name|
          accreditation_sheet = accredited_suppliers_workbook.sheet(sheet_name)

          accreditation_sheet.column(1)[1..]
        end.flatten
      end

      accredited_suppliers_names
    end
  end
end
