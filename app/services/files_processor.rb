class FilesProcessor
  include FilesImporterHelper

  def initialize(upload)
    @upload = upload
    @supplier_data = []
  end

  def process_files
    self.class::PROCESS_FILES_AND_METHODS.each do |file, check_method|
      read_spreadsheet(file) do |workbook|
        send(check_method, workbook)
      end
    end

    clean_supplier_data_service_and_rates

    @supplier_data
  end

  private

  def clean_supplier_data_service_and_rates
    @supplier_data.each do |supplier|
      supplier[:supplier_frameworks][0][:supplier_framework_lots_data].each do |lot_id, jurisdictions|
        jurisdictions[:jurisdiction].each do |jurisdiction_id, service_and_rates|
          supplier[:supplier_frameworks][0][:supplier_framework_lots] << {
            lot_id: lot_id,
            jurisdiction_id: jurisdiction_id,
            enabled: true,
            supplier_framework_lot_services: service_and_rates[:services],
            supplier_framework_lot_rates: service_and_rates[:rates],
            supplier_framework_lot_branches: [],
          }
        end
      end

      supplier[:supplier_frameworks][0].delete(:supplier_framework_lots_data)
    end
  end
end
