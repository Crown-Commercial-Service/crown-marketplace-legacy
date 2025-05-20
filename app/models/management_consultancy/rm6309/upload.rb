module ManagementConsultancy
  module RM6309
    class Upload < Upload
      self.table_name = 'management_consultancy_rm6309_uploads'

      def self.create_supplier!(data)
        supplier = Supplier.create!(
          id: data['supplier_id'],
          name: data['name'],
          contact_name: data['contact_name'],
          contact_email: data['contact_email'],
          telephone_number: data['telephone_number'],
          sme: data['sme'],
          address: data['address'],
          website: data['website'],
          duns: data['duns']
        )

        lots = data.fetch('lots', [])
        lots.each do |lot|
          lot_number = lot['lot_number']
          services = lot.fetch('services', [])
          services.each do |service|
            supplier.service_offerings.create!(
              lot_number: lot_number,
              service_code: service
            )
          end
        end

        rate_cards = data.fetch('rate_cards', [])

        rate_cards.each do |rate_card|
          supplier.rate_cards.create!(rate_card)
        end
      end
    end
  end
end
