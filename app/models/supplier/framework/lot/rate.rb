class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Lot < ApplicationRecord
      class Rate < ApplicationRecord
        belongs_to :supplier_framework_lot, inverse_of: :rates, class_name: 'Supplier::Framework::Lot'
        belongs_to :position, inverse_of: :supplier_framework_lot_rates
      end
    end
  end
end
