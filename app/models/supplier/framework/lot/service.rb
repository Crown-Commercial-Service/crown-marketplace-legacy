class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Lot < ApplicationRecord
      class Service < ApplicationRecord
        belongs_to :supplier_framework_lot, inverse_of: :services, class_name: 'Supplier::Framework::Lot'
        belongs_to :service, inverse_of: :supplier_framework_lot_services

        has_many :rates, class_name: 'Supplier::Framework::Lot::Rate', dependent: :destroy
      end
    end
  end
end
