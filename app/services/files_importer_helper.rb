module FilesImporterHelper
  def read_spreadsheet(file)
    workbook = current_spreadsheet(file)

    yield(workbook)

    workbook.close
  end

  def current_spreadsheet(file)
    tmpfile = Tempfile.create
    tmpfile.binmode
    tmpfile.write @upload.send(file).download
    tmpfile.close

    Roo::Spreadsheet.open(tmpfile.path, extension: :xlsx)
  end

  def get_supplier(supplier_duns)
    @supplier_data.find { |s| s['duns'] == supplier_duns }
  end

  def extract_duns(supplier_name)
    supplier_name[/(?<=\[)(.*?)(?=\])/].to_i
  end

  def extract_region_code(region_name)
    region_name[/(?<=\()(.*?)(?=\))/]
  end

  def extract_service_number(service_name)
    service_name[/(?<=\[)(.*?)(?=\])/]
  end

  def number_of_sheets(workbook)
    workbook.sheets.size
  end
end
