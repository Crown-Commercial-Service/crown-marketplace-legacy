class Lot < ApplicationRecord
  belongs_to :framework, inverse_of: :lots

  has_many :services, inverse_of: :lot, dependent: :destroy
end
