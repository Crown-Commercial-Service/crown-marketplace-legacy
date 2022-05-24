class Framework < ApplicationRecord
  scope :supply_teachers, -> { where(service: 'supply_teachers').order(live_at: :asc) }
  scope :management_consultancy, -> { where(service: 'management_consultancy').order(live_at: :asc) }
  scope :legal_services, -> { where(service: 'legal_services').order(live_at: :asc) }

  acts_as_gov_uk_date :live_at, error_clash_behaviour: :omit_gov_uk_date_field_error
  validate :live_at_date_present, :live_at_date_real, on: :update

  def self.frameworks
    pluck(:framework)
  end

  def self.live_frameworks
    where('live_at <= ?', Time.now.in_time_zone('London')).pluck(:framework)
  end

  def self.current_framework
    live_frameworks.last
  end

  def self.current_live_framework?(framework)
    current_framework == framework
  end

  def self.recognised_framework?(framework)
    frameworks.include?(framework)
  end

  def status
    if self.class.send(service).current_live_framework?(framework)
      :live
    else
      live_at <= Time.now.in_time_zone('London') ? :expired : :coming
    end
  end

  private

  def live_at_date_present
    errors.add(:live_at, :blank) if live_at_yyyy.blank? || live_at_mm.blank? || live_at_dd.blank?
  end

  def live_at_date_real
    errors.add(:live_at, :not_a_date) unless Date.valid_date?(live_at_yyyy.to_i, live_at_mm.to_i, live_at_dd.to_i)
  end
end
