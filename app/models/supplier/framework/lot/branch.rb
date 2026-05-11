class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Lot < ApplicationRecord
      class Branch < ApplicationRecord
        extend FriendlyId

        MAX_FIELD_LENGTH = 255

        friendly_id :supplier_name, use: :slugged

        belongs_to :supplier_framework_lot, inverse_of: :branches, class_name: 'Supplier::Framework::Lot'

        delegate :supplier_name, to: :supplier_framework_lot

        with_options on: %i[branches] do
          before_validation(:make_contact_email_downcase, *%i[name region contact_name contact_email telephone_number address_line_1 address_line_2 town county postcode].map { |attribute| :"remove_excess_whitespace_from_#{attribute}" })
          after_validation :find_location

          validates :name, presence: true, length: { maximum: MAX_FIELD_LENGTH }
          validates :region, presence: true, length: { maximum: MAX_FIELD_LENGTH }
          validates :contact_name, presence: true, length: { maximum: MAX_FIELD_LENGTH }
          validates :contact_email, format: { with: /\A[^\s^@]+@[^\s^@]+\z/, message: :blank }, presence: true, length: { maximum: MAX_FIELD_LENGTH }
          validates :telephone_number, presence: true, format: { with: /\A\d{11}\z|\A\d{5} \d{6}\z|\A\d{3} \d{4} \d{4}\z/, message: :blank }
          validates :address_line_1, presence: true, length: { maximum: MAX_FIELD_LENGTH }
          validates :address_line_2, length: { maximum: MAX_FIELD_LENGTH }
          validates :town, presence: true, length: { maximum: MAX_FIELD_LENGTH }
          validates :county, length: { maximum: MAX_FIELD_LENGTH }
          validates :postcode, presence: true, postcode: true
        end

        validates :postcode, presence: true, postcode: true
        validates :location, presence: true
        validates :telephone_number, presence: true
        validates :contact_name, presence: true
        validates :contact_email, presence: true

        def self.search(point, lot_id:, radius:, position_id: nil)
          query = includes(
            supplier_framework_lot: [:rates, { supplier_framework: :supplier }]
          ).joins(
            supplier_framework_lot: [:rates, { supplier_framework: :supplier }]
          ).where(
            'ST_DWithin(location, :point, :within_metres)',
            { point: point, within_metres: DistanceConverter.miles_to_metres(radius) }
          ).where(
            supplier_framework_lot: { lot_id: lot_id, enabled: true, supplier_frameworks: { enabled: true } }
          )

          if position_id
            query = query.merge(
              Rate.where(position_id:)
            )
          end

          query.order(
            Rate.arel_table[:rate].asc
          ).order(
            Arel.sql("ST_Distance(location, '#{point}')")
          )
        end

        def address_elements
          [address_line_1, address_line_2, town, county, postcode].compact_blank
        end

        private

        %i[name region contact_name contact_email telephone_number address_line_1 address_line_2 town county postcode].each do |attribute|
          define_method(:"remove_excess_whitespace_from_#{attribute}") { remove_excess_whitespace(attribute) }
        end

        %i[contact_email].each do |attribute|
          define_method(:"make_#{attribute}_downcase") { make_downcase(attribute) }
        end

        def remove_excess_whitespace(attribute)
          public_send(attribute)&.squish!
        end

        def make_downcase(attribute)
          public_send(attribute)&.downcase!
        end

        def find_location
          return if errors[:postcode].any?

          location = Location.new(postcode)

          errors.add(:postcode, :location_not_found) unless location.found?

          self.location = location.point
        rescue SocketError, Timeout::Error, Geocoder::OverQueryLimitError, Geocoder::RequestDenied, Geocoder::InvalidRequest, Geocoder::InvalidApiKey, Geocoder::ServiceUnavailable => e
          Rollbar.log('error', e)
          errors.add(:postcode, :location_not_found)
        end
      end
    end
  end
end
