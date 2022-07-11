module SupplyTeachers
  module RM6238
    module Admin
      class DataImport < SupplyTeachers::DataImport
        IMPORT_PROCESS_ORDER = %i[generate_branches generate_pricing generate_accreditation merge_data exclude_suppliers_without_accreditation add_vendor_contacts validate_and_geocode strip_line_numbers upload_data_and_errors].freeze

        private

        def merge_data_sets
          [
            ['pricing supplier name', 'branches supplier name', @supplier_pricing],
            ['accreditation supplier name', 'branches supplier name', @supplier_accreditation]
          ]
        end
      end
    end
  end
end
