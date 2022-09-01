class SupplyTeachers::RM3826::Spreadsheet < SupplyTeachers::Spreadsheet
  class DataDownload < SupplyTeachers::Spreadsheet::DataDownload
    def initialize(fixed_term_results: nil); end

    def headers
      ['Agency name', 'Branch name', 'Contact name', 'Contact email', 'Telephone number']
    end

    def types
      %i[string string string string string]
    end

    def row(branch, _row_num)
      [branch.supplier_name,
       branch.name,
       branch.contact_name,
       branch.contact_email,
       format_telephone_number(branch.telephone_number)]
    end

    def style(workbook, sheet); end
  end

  class Shortlist < DataDownload
    def sheet_name
      'Agency shortlist'
    end

    def title
      extra_title =
        ['', '', '', '', '', 'Enter the quote from this agency to see what their fee will be']
      super + extra_title
    end

    def headers
      extra_headers =
        ['Mark-up', 'Enter daily rate', 'Cost of the worker', 'Agency fee']
      super + extra_headers
    end

    def types
      super + [:float, nil, nil, nil]
    end

    def row(branch, row)
      extra_fields =
        [branch.rate, '', formula(row, 'G#/(1+F#)'), formula(row, 'G#-H#')]
      super + extra_fields
    end

    def formula(row_num, formula)
      "=#{formula.gsub('#', row_num.to_s)}"
    end

    def style(workbook, sheet)
      workbook.styles do |s|
        percent = s.add_style(format_code: '0%')
        money = s.add_style(format_code: '[$£-809]##,##0.00')
        sheet.col_style 5, percent
        sheet.col_style 6, money
        sheet.col_style 7, money
        sheet.col_style 8, money
        sheet.column_widths(nil, nil, nil, nil, nil, nil, 20, 20, 20)
      end
    end
  end
end
