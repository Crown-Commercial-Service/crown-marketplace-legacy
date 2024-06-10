module SupplyTeachers
  module RM6238
    class Upload < SupplyTeachers::Upload
      self.table_name = 'supply_teachers_rm6238_uploads'

      def self.create_supplier!(data)
        s = super

        [
          ['master_vendor_contacts', '2'],
          ['education_technology_platform_contacts', '4']
        ].each do |managed_service_provider, lot_number|
          managed_service_provider_contact = data.fetch(managed_service_provider, {})

          next if managed_service_provider_contact.blank?

          create_managed_service_provider_contacts(s, lot_number, managed_service_provider_contact)
        end

        rates = data.fetch('pricing', [])
        create_supplier_rates!(s, rates)
      end

      def self.supplier_attributes(data)
        {
          id: data['supplier_id'],
          name: data['supplier_name'],
        }
      end

      def self.create_managed_service_provider_contacts(supplier, lot_number, managed_service_provider_contacts)
        supplier.managed_service_providers.create!(
          lot_number: lot_number,
          contact_name: managed_service_provider_contacts['name'],
          telephone_number: managed_service_provider_contacts['telephone'],
          contact_email: managed_service_provider_contacts['email']
        )
      end

      def self.create_supplier_rates!(supplier, rates)
        rates.each do |rate_data|
          supplier.rates.create!(
            lot_number: rate_data['lot_number'],
            job_type: rate_data['job_type'],
            term: rate_data['term'],
            rate: rate_data['fee']
          )
        end
      end
    end
  end
end
