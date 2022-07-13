module SupplyTeachers
  module RM3826
    module Admin
      class DataImport::GenerateBranches < SupplyTeachers::DataImport::GenerateBranches
        include SupplyTeachers::RM3826::Admin::DataImport::Helper
      end
    end
  end
end
