class SupplyTeachers::RM6238::Spreadsheet < SupplyTeachers::Spreadsheet
  class DataDownload < SupplyTeachers::Spreadsheet::DataDownload
    def initialize(fixed_term_results: false)
      @fixed_term_results = fixed_term_results
      @devisor = fixed_term_results ? 100.0 : 1.0
    end

    def headers
      ['Agency name', 'Branch name', 'Contact name', 'Contact email', 'Telephone number', 'Supplier fee', 'Miles']
    end

    def types
      %i[string string string string string] + [nil, :float]
    end

    def row(branch, _row_num)
      [
        branch.supplier_name,
        branch.name,
        branch.contact_name,
        branch.contact_email,
        format_telephone_number(branch.telephone_number),
        branch.rate&./(@devisor),
        DistanceConverter.metres_to_miles(branch.distance).round(1)
      ]
    end

    def style(workbook, sheet)
      workbook.styles do |s|
        style = if @fixed_term_results
                  s.add_style(format_code: '0%')
                else
                  s.add_style(format_code: '[$£-809]##,##0.00')
                end

        sheet.col_style 5, style
      end
    end
  end
end
