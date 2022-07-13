module SupplyTeachers
  module RM3826
    module Admin
      class DataImport::AddVendorContacts < SupplyTeachers::DataImport::AddVendorContacts
        include SupplyTeachers::RM3826::Admin::DataImport::Helper

        OTHER_MANAGED_SERVICE_PROVIDER = :neutral_vendor_contacts
      end
    end
  end
end
