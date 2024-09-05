class Framework::Lot::Service < ApplicationRecord
  belongs_to :lot, foreign_key: :framework_lot_id, inverse_of: :services
end
