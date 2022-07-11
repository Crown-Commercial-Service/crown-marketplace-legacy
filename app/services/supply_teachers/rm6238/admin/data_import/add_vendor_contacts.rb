module SupplyTeachers
  module RM6238
    module Admin
      class DataImport::AddVendorContacts < SupplyTeachers::DataImport::AddVendorContacts
        include SupplyTeachers::RM6238::Admin::DataImport::Helper

        OTHER_MANAGED_SERVICE_PROVIDER = :education_technology_platform_contacts
      end
    end
  end
end
