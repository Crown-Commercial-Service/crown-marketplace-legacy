class SupplyTeachers::AddVendorContacts
  include SupplyTeachers::DataImportHelper

  attr_reader :data_with_vendors

  def initialize(current_data, data_with_vendors)
    @current_data = current_data
    @data_with_vendors = data_with_vendors
  end

  def add_vendor_contacts
    master_details = []
    neutral_details = []

    read_csv(@current_data.master_vendor_contacts) do |csv|
      master_details = csv.index_by { |r| r['supplier_name'] }
    end

    read_csv(@current_data.neutral_vendor_contacts) do |csv|
      neutral_details = csv.index_by { |r| r['supplier_name'] }
    end

    @data_with_vendors.map! do |supplier|
      supplier_name = supplier.fetch(:supplier_name)

      master = master_details[supplier_name]
      if master
        supplier.merge!(
          master_vendor_contact: {
            name: master.fetch('contact_name'),
            telephone: master.fetch('contact_telephone'),
            email: master.fetch('contact_email')
          }
        )
      end

      neutral = neutral_details[supplier_name]
      if neutral
        supplier.merge!(
          neutral_vendor_contact: {
            name: neutral.fetch('contact_name'),
            telephone: neutral.fetch('contact_telephone'),
            email: neutral.fetch('contact_email')
          }
        )
      end

      supplier
    end
  end
end
