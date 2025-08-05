class SupplierSpreadsheetCreator
  def initialize(supplier_frameworks, params)
    @supplier_frameworks = supplier_frameworks
    @params = params
  end

  def build
    Axlsx::Package.new do |package|
      yield(
        package.workbook.add_worksheet(name: 'Supplier shortlist'),
        package.workbook.add_worksheet(name: 'Shortlist audit')
      )
    end
  end

  private

  def add_services(sheet)
    services = Service.where(id: @params['service_ids']).order(:id).pluck(:name)
    sheet.add_row ['Services', services.join(', ')]
  end
end
