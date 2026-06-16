class Jurisdiction < ApplicationRecord
  belongs_to :framework, inverse_of: :jurisdictions

  has_many :supplier_framework_lot_jurisdictions, inverse_of: :jurisdiction, class_name: 'Supplier::Framework::Lot::Jurisdiction', dependent: :destroy

  scope :core, -> { where(framework_id: 'RM6360', category: 'core') }
  scope :non_core, -> { where(framework_id: 'RM6360', category: 'non-core') }
end
