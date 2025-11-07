class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Lot < ApplicationRecord
      class Rate < ApplicationRecord
        belongs_to :supplier_framework_lot, inverse_of: :rates, class_name: 'Supplier::Framework::Lot'
        belongs_to :position, inverse_of: :supplier_framework_lot_rates
        belongs_to :jurisdiction, inverse_of: :rates, class_name: 'Supplier::Framework::Lot::Jurisdiction', foreign_key: :supplier_framework_lot_jurisdiction_id

        delegate :rate_type, to: :position
        delegate :mandatory, to: :position

        def normalized_rate
          rate / 100.0
        end

        def rate_as_percentage_decimal
          rate / 10000.0
        end
      end
    end
  end
end
