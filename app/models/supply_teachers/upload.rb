module SupplyTeachers
  class Upload < ApplicationRecord
    def self.supplier_module
      module_parent::Supplier
    end

    def self.upload!(suppliers)
      error = all_or_none(supplier_module) do
        supplier_module.destroy_all

        suppliers.map do |supplier_data|
          create_supplier!(supplier_data)
        end
        create!
      end
      raise error if error
    end

    def self.all_or_none(transaction_class)
      error = nil
      transaction_class.transaction do
        yield
      rescue ActiveRecord::RecordInvalid => e
        error = e
        raise ActiveRecord::Rollback
      end
      error
    end

    def self.create_supplier!(data)
      s = supplier_module.create!(supplier_attributes(data))

      branches = data.fetch('branches', [])
      branches.each do |branch|
        s.branches.create!(branch_attributes(branch))
      end

      s
    end

    def self.branch_attributes(branch)
      contact_name = branch.dig('contacts', 0, 'name')
      contact_email = branch.dig('contacts', 0, 'email')
      {
        name: branch['branch_name'],
        town: branch['town'],
        address_1: branch['address_1'],
        address_2: branch['address_2'],
        county: branch['county'],
        region: branch['region'],
        postcode: branch['postcode'],
        location: Geocoding.point(
          latitude: branch['lat'],
          longitude: branch['lon']
        ),
        telephone_number: branch['telephone'],
        contact_name: contact_name,
        contact_email: contact_email
      }
    end
  end
end