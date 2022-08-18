module LegalServices
  module RM3788
    class Upload < Upload
      self.table_name = 'legal_services_rm3788_uploads'

      # rubocop:disable Metrics/AbcSize
      def self.create_supplier!(data)
        supplier = Supplier.create!(
          id: data['supplier_id'],
          name: data['name'],
          email: data['email'],
          phone_number: data['phone_number'],
          sme: data['sme'],
          address: data['address'],
          website: data['website'],
          duns: data['duns'],
          rate_cards: data['rate_cards'],
          lot_1_prospectus_link: data['lot_1_prospectus_link'],
          lot_2_prospectus_link: data['lot_2_prospectus_link'],
          lot_3_prospectus_link: data['lot_3_prospectus_link'],
          lot_4_prospectus_link: data['lot_4_prospectus_link'],
        )

        lot_1_services = data.fetch('lot_1_services', {})
        lot_1_services.each do |service|
          supplier.regional_availabilities.create!(
            region_code: service['region_code'],
            service_code: service['service_code']
          )
        end

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
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
