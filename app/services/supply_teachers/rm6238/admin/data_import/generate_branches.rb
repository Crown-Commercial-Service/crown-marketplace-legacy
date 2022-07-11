module SupplyTeachers
  module RM6238
    module Admin
      class DataImport::GenerateBranches < SupplyTeachers::DataImport::GenerateBranches
        include SupplyTeachers::RM6238::Admin::DataImport::Helper
      end
    end
  end
end
