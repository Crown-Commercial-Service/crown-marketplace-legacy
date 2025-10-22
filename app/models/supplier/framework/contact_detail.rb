class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class ContactDetail < ApplicationRecord
      belongs_to :supplier_framework, inverse_of: :contact_detail, class_name: 'Supplier::Framework'

      MAX_FIELD_LENGTH = 255
      ADDITIONAL_DETAILS_ATTRIBUTES = %i[address lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4a_prospectus_link lot_4b_prospectus_link lot_4c_prospectus_link lot_5_prospectus_link].freeze

      store_accessor :additional_details, ADDITIONAL_DETAILS_ATTRIBUTES

      with_options on: %i[supplier_contact_information] do
        before_validation :remove_excess_whitespace_from_name, :remove_excess_whitespace_from_email, :make_email_downcase, :remove_excess_whitespace_from_telephone_number, :remove_excess_whitespace_from_website

        validates :name, presence: true, length: { maximum: MAX_FIELD_LENGTH }, unless: -> { self.class::ATTRIBUTES_TO_SKIP_VALIDATION.include?(:name) }
        validates :email, presence: true, format: { with: /\A[^\s^@]+@[^\s^@]+\z/, message: :blank }, length: { maximum: MAX_FIELD_LENGTH }
        validates :telephone_number, presence: true, format: { with: /\A\d{11}\z|\A\d{5} \d{6}\z|\A\d{3} \d{4} \d{4}\z/, message: :blank }
        validates :website, presence: true, length: { maximum: MAX_FIELD_LENGTH }
        validate :website_is_a_valid_url, if: -> { errors[:website].none? }
      end

      with_options on: %i[additional_supplier_information] do
        before_validation :remove_excess_whitespace_from_address, :remove_excess_whitespace_from_lot_1_prospectus_link, :remove_excess_whitespace_from_lot_2_prospectus_link, :remove_excess_whitespace_from_lot_3_prospectus_link, :remove_excess_whitespace_from_lot_4a_prospectus_link, :remove_excess_whitespace_from_lot_4b_prospectus_link, :remove_excess_whitespace_from_lot_4c_prospectus_link, :remove_excess_whitespace_from_lot_5_prospectus_link

        validates :address, presence: true, length: { maximum: MAX_FIELD_LENGTH }

        %i[lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4a_prospectus_link lot_4b_prospectus_link lot_4c_prospectus_link lot_5_prospectus_link].each do |attribute|
          validates attribute, length: { maximum: MAX_FIELD_LENGTH }, unless: -> { self.class::ATTRIBUTES_TO_SKIP_VALIDATION.include?(attribute) }
          validate :"#{attribute}_is_a_valid_url", if: -> { public_send(attribute).present? && errors[attribute].none? }, unless: -> { self.class::ATTRIBUTES_TO_SKIP_VALIDATION.include?(attribute) }
        end
      end

      private

      %i[name email telephone_number website address lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4a_prospectus_link lot_4b_prospectus_link lot_4c_prospectus_link lot_5_prospectus_link].each do |attribute|
        define_method(:"remove_excess_whitespace_from_#{attribute}") { remove_excess_whitespace(attribute) }
      end

      %i[website lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4a_prospectus_link lot_4b_prospectus_link lot_4c_prospectus_link lot_5_prospectus_link].each do |attribute|
        define_method(:"#{attribute}_is_a_valid_url") { attribute_is_a_valid_url(attribute) }
      end

      def remove_excess_whitespace(attribute)
        public_send(attribute)&.squish!
      end

      def make_email_downcase
        email&.downcase!
      end

      def attribute_is_a_valid_url(attribute)
        errors.add(attribute, :blank) unless url_valid?(public_send(attribute))
      end

      def url_valid?(url)
        uri = URI.parse(url)
        uri.is_a?(URI::HTTP) && uri.host.present?
      rescue URI::InvalidURIError
        false
      end
    end
  end
end
