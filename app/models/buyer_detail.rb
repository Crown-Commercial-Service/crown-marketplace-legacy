class BuyerDetail < ApplicationRecord
  belongs_to :user, inverse_of: :buyer_detail

  MAX_FIELD_LENGTH = 255
  SECTORS = %w[culture_media_and_sport defence_and_security education government_policy health infrastructure local_community_and_housing].freeze

  with_options on: %i[update personal_details] do
    validates :name, presence: true, length: { maximum: MAX_FIELD_LENGTH }
    validates :job_title, presence: true, length: { maximum: MAX_FIELD_LENGTH }
  end

  with_options on: %i[update organisation_details] do
    validates :organisation_name, length: { maximum: MAX_FIELD_LENGTH }, presence: true
    validates :organisation_sector, inclusion: { in: SECTORS }
  end

  delegate :email, to: :user

  def organisation_sector_name
    I18n.t("buyer_details.sections.organisation_details.organisation_sector.options.#{organisation_sector}")
  end

  def details_complete?
    valid?(:update)
  end
end
