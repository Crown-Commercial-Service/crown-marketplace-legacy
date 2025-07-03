class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Branch < ApplicationRecord
      belongs_to :supplier_framework, inverse_of: :branches, class_name: 'Supplier::Framework'
    end
  end
end
