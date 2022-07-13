module SupplyTeachers
  class DataImport::AddVendorContacts
    include SupplyTeachers::DataImport::Helper

    attr_reader :data_with_vendors

    def initialize(current_data, data_with_vendors)
      @current_data = current_data
      @data_with_vendors = data_with_vendors
    end

    def add_vendor_contacts
      msp_details = {}

      [:master_vendor_contacts, self.class::OTHER_MANAGED_SERVICE_PROVIDER].each do |key|
        read_csv(@current_data.send(key)) do |csv|
          msp_details[key] = csv.index_by { |r| r['supplier_name'] }
        end
      end

      @data_with_vendors.map! do |supplier|
        supplier_name = supplier.fetch(:supplier_name)

        msp_details.each do |key, details|
          msp = details[supplier_name]

          next unless msp

          supplier.merge!(
            key => {
              name: msp.fetch('contact_name'),
              telephone: msp.fetch('contact_telephone'),
              email: msp.fetch('contact_email')
            }
          )
        end

        supplier
      end
    end
  end
end
