module SupplyTeachers
  class Branch < ApplicationRecord
    self.abstract_class = true

    validates :postcode, presence: true, postcode: true
    validates :location, presence: true
    validates :telephone_number, presence: true
    validates :contact_name, presence: true
    validates :contact_email, presence: true

    def self.near(point, within_metres:)
      where(
        [
          'ST_DWithin(location, :point, :within_metres)',
          { point: point, within_metres: within_metres }
        ]
      )
    end

    delegate :name, to: :supplier, prefix: true

    def address_elements
      [address_1, address_2, town, county, postcode].reject(&:blank?)
    end
  end
end
