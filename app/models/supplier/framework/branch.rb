class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Branch < ApplicationRecord
      extend FriendlyId

      friendly_id :supplier_name, use: :slugged

      belongs_to :supplier_framework, inverse_of: :branches, class_name: 'Supplier::Framework'

      delegate :supplier_name, to: :supplier_framework
    end
  end
end
