class Jurisdiction < ApplicationRecord
  has_many :supplier_framework_lots, inverse_of: :jurisdiction, class_name: 'Supplier::Framework::Lot', dependent: :destroy
end
