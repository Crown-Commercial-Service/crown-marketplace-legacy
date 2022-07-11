module SupplyTeachers
  module RM3826
    module Admin
      class DataImport::GenerateAccreditation < SupplyTeachers::DataImport::GenerateAccreditation
        include SupplyTeachers::RM3826::Admin::DataImport::Helper

        SHEETS_AND_TITLES = [
          ['Lot 1 - Preferred Supplier List', 'Supplier Name - Accreditation Held'],
          ['Lot 2 - Master Vendor MSP', 'Supplier Name - Accreditation Held'],
          ['Lot 3 - Neutral Vendor MSP', 'Supplier Name']
        ].freeze
      end
    end
  end
end
