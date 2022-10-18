module Frameworks
  def self.rm6238_expires_at
    if Rails.env.test?
      Time.zone.now + 1.year
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2026, 9, 1).in_time_zone('London')
    end
  end

  def self.rm3788_expires_at
    if Rails.env.test?
      Time.zone.now + 1.year
    else
      Time.new(2022, 10, 3).in_time_zone('London')
    end
  end

  def self.rm6240_expires_at
    if Rails.env.test?
      Time.zone.now + 1.year
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2026, 10, 1).in_time_zone('London')
    end
  end

  def self.add_frameworks
    ActiveRecord::Base.connection.truncate_tables(:frameworks)
    Framework.create(service: 'supply_teachers', framework: 'RM6238', live_at: Time.new(2022, 9, 12).in_time_zone('London'), expires_at: rm6238_expires_at)
    Framework.create(service: 'management_consultancy', framework: 'RM6187', live_at: Time.new(2021, 9, 4).in_time_zone('London'), expires_at: Time.new(2025, 9, 4).in_time_zone('London'))
    Framework.create(service: 'legal_services', framework: 'RM3788', live_at: Time.new(2020, 6, 26).in_time_zone('London'), expires_at: rm3788_expires_at)
    Framework.create(service: 'legal_services', framework: 'RM6240', live_at: Time.new(2022, 10, 3).in_time_zone('London'), expires_at: rm6240_expires_at)
  end
end

namespace :db do
  desc 'add the frameworks into the database'
  task legacy_frameworks: :environment do
    p 'Loading Legacy Frameworks'
    DistributedLocks.distributed_lock(157) do
      Frameworks.add_frameworks
    end
  end

  desc 'add static data to the database'
  task static: :legacy_frameworks do
  end
end
