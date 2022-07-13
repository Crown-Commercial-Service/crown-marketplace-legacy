module SupplyTeachers
  module RM6238
    module Admin
      class DataImport::ValidateAndGeocode < SupplyTeachers::DataImport::ValidateAndGeocode
        include SupplyTeachers::RM6238::Admin::DataImport::Helper

        private

        def add_empty_lists(supplier)
          supplier[:branches] ||= []
          supplier[:pricing] ||= []
        end

        def check_pricing_present(supplier)
          @errors << "'Pricing' cannot be found for the following supplier: #{supplier[:supplier_name]}." if supplier[:pricing].try(:empty?)
        end
      end
    end
  end
end
