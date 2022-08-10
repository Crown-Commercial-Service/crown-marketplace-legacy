module LegalServices
  module RM6240
    class Upload < Upload
      self.table_name = 'legal_services_rm6240_uploads'

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
          lot_1_prospectus_link: data['lot_1_prospectus_link'],
          lot_2_prospectus_link: data['lot_2_prospectus_link'],
          lot_3_prospectus_link: data['lot_3_prospectus_link']
        )

        supplier.service_offerings.create!(data['service_offerings'])
        supplier.rates.create!(data['rates'])
      end
    end
  end
end
