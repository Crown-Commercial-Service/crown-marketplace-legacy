module SupplyTeachers
  module RM3826
    module Admin
      class DataImport::ValidateAndGeocode < SupplyTeachers::DataImport::ValidateAndGeocode
        include SupplyTeachers::RM3826::Admin::DataImport::Helper

        private

        def add_empty_lists(supplier)
          supplier[:branches] ||= []
          supplier[:pricing] ||= []
          supplier[:master_vendor_pricing] ||= []
          supplier[:neutral_vendor_pricing] ||= []
        end

        def check_pricing_present(supplier)
          @errors << "'Pricing' cannot be found for the following supplier: #{supplier[:supplier_name]}." unless [supplier[:pricing].try(:empty?), supplier[:master_vendor_pricing].try(:empty?), supplier[:neutral_vendor_pricing].try(:empty?)].any? { |s| s == false }
        end
      end
    end
  end
end
