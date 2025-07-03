class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    belongs_to :supplier, inverse_of: :supplier_frameworks
    belongs_to :framework, inverse_of: :supplier_frameworks

    has_one :contact_detail, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::ContactDetail', dependent: :destroy
    has_one :address, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::Address', dependent: :destroy

    has_many :lots, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::Lot', dependent: :destroy
    has_many :branches, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::Branch', dependent: :destroy
  end
end
