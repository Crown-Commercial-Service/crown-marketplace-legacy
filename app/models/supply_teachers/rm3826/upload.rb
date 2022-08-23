module SupplyTeachers
  module RM3826
    class Upload < SupplyTeachers::Upload
      self.table_name = 'supply_teachers_rm3826_uploads'

      def self.create_supplier!(data)
        s = super(data)

        rates = data.fetch('pricing', [])
        create_supplier_rates!(s, 1, rates)

        master_vendor_rates = data.fetch('master_vendor_pricing', [])
        create_supplier_rates!(s, 2, master_vendor_rates)

        neutral_vendor_rates = data.fetch('neutral_vendor_pricing', [])
        create_supplier_rates!(s, 3, neutral_vendor_rates)
      end

      def self.supplier_attributes(data)
        master_vendor_contact = data.fetch('master_vendor_contacts', {})
        neutral_vendor_contact = data.fetch('neutral_vendor_contacts', {})

        {
          id: data['supplier_id'],
          name: data['supplier_name'],
          master_vendor_contact_name: master_vendor_contact['name'],
          master_vendor_telephone_number: master_vendor_contact['telephone'],
          master_vendor_contact_email: master_vendor_contact['email'],
          neutral_vendor_contact_name: neutral_vendor_contact['name'],
          neutral_vendor_telephone_number: neutral_vendor_contact['telephone'],
          neutral_vendor_contact_email: neutral_vendor_contact['email']
        }
      end

      def self.create_supplier_rates!(supplier, lot_number, rates)
        rates.each do |rate_data|
          rate = supplier.rates.build(
            lot_number: lot_number,
            job_type: rate_data['job_type'],
            term: rate_data['term']
          )
          if rate.daily_fee?
            rate.daily_fee = rate_data['fee']
          else
            rate.mark_up = rate_data['fee'].to_f
          end
          rate.save!
        end
      end
    end
  end
end
