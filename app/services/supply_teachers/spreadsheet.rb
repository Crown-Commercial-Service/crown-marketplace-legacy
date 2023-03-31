class SupplyTeachers::Spreadsheet
  class DataDownload
    include TelephoneNumberHelper

    def sheet_name
      'Agency shortlist'
    end

    def title
      ['Agency list']
    end
  end

  def initialize(branches, with_calculations: false, slug: nil)
    @branches = branches
    @format = with_calculations ? self.class::Shortlist.new : self.class::DataDownload.new(fixed_term_results: slug == 'fixed-term-results')
  end

  def to_xlsx(with_calculations: false)
    spreadsheet(@format.sheet_name) do |workbook, sheet|
      sheet.add_row @format.title
      sheet.merge_cells 'G1:I1' if with_calculations
      sheet.add_row @format.headers
      @branches.each.with_index(3) do |branch, i|
        sheet.add_row @format.row(branch, i), types: @format.types
      end
      @format.style(workbook, sheet)
    end
  end

  private

  def spreadsheet(name)
    package = Axlsx::Package.new
    workbook = package.workbook
    workbook.add_worksheet(name:) do |sheet|
      yield workbook, sheet
    end
    package.to_stream.read
  end
end
