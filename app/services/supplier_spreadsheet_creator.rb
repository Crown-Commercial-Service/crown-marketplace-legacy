class SupplierSpreadsheetCreator
  def initialize(suppliers, params, service_model)
    @suppliers = suppliers
    @params = params
    @service_model = service_model
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
    services = @params['services'].map { |service_code| @service_model.find_by(code: service_code).name }
    sheet.add_row ['Services', services.join(', ')]
  end
end
