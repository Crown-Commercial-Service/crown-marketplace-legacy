class Service < ApplicationRecord
  belongs_to :lot, inverse_of: :services
end
