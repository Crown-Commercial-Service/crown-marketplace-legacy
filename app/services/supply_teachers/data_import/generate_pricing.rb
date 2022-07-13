module SupplyTeachers
  class DataImport::GeneratePricing
    include SupplyTeachers::DataImport::Helper

    attr_reader :supplier_pricing, :errors

    def initialize(current_data)
      @current_data = current_data
      @errors = []
    end

    def generate_pricing
      @supplier_pricing = collate(pricing)
    end
  end
end
