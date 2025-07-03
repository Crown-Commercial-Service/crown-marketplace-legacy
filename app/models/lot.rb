class Lot < ApplicationRecord
  belongs_to :framework, inverse_of: :lots

  has_many :services, inverse_of: :lot, dependent: :destroy
  has_many :supplier_framework_lots, inverse_of: :lot, class_name: 'Supplier::Framework::Lot', dependent: :destroy
end
