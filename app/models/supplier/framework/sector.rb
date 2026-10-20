class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Sector < ApplicationRecord
      self.table_name = 'supplier_framework_sectors'

      belongs_to :supplier_framework, inverse_of: :sectors, class_name: 'Supplier::Framework'
      belongs_to :sector, inverse_of: :supplier_framework_sectors, class_name: '::Sector'

      validates :sector_id, uniqueness: { scope: :supplier_framework_id }
    end
  end
end
