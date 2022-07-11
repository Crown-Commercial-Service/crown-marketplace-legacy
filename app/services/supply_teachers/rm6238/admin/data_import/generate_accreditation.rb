module SupplyTeachers
  module RM6238
    module Admin
      class DataImport::GenerateAccreditation < SupplyTeachers::DataImport::GenerateAccreditation
        include SupplyTeachers::RM6238::Admin::DataImport::Helper

        SHEETS_AND_TITLES = [
          ['Lot 1 - Preferred Supplier List', 'Supplier Name - Accreditation Held'],
          ['Lot 2 - Master Vendor', 'Supplier Name'],
          ['Lot 4 - Education technology', 'Supplier Name']
        ].freeze
      end
    end
  end
end
