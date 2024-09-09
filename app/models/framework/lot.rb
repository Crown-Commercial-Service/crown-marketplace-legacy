class Framework::Lot < ApplicationRecord
  belongs_to :framework
  has_many :services, foreign_key: :framework_lot_id, dependent: :destroy, inverse_of: :lot
end
