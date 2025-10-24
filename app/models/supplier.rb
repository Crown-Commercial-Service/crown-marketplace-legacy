class Supplier < ApplicationRecord
  has_many :supplier_frameworks, inverse_of: :supplier, class_name: 'Supplier::Framework', dependent: :destroy

  MAX_FIELD_LENGTH = 255

  validates :name, presence: true, uniqueness: true
  validates :duns_number, uniqueness: true, allow_nil: true

  with_options on: %i[basic_supplier_information] do
    before_validation :remove_excess_whitespace_from_name, :remove_excess_whitespace_from_duns_number

    validates :name, presence: true, uniqueness: true, length: { maximum: MAX_FIELD_LENGTH }
    validates :duns_number, presence: true, uniqueness: true, format: { with: /\A\d{9}\z/ }, unless: -> { self.class::ATTRIBUTES_TO_SKIP_VALIDATION.include?(:duns_number) }
    validates :sme, inclusion: { in: [true, false] }, unless: -> { self.class::ATTRIBUTES_TO_SKIP_VALIDATION.include?(:sme) }
  end

  private

  %i[name duns_number].each do |attribute|
    define_method(:"remove_excess_whitespace_from_#{attribute}") { remove_excess_whitespace(attribute) }
  end

  def remove_excess_whitespace(attribute)
    self[attribute]&.squish!
  end
end
