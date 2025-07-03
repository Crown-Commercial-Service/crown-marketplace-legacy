module Frameworks
  def self.rm6238_expires_at
    if Rails.env.test?
      1.year.from_now
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2026, 9, 1).in_time_zone('London')
    end
  end

  def self.rm6240_expires_at
    if Rails.env.test?
      1.year.from_now
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2026, 10, 1).in_time_zone('London')
    end
  end

  def self.rm6187_expires_at
    if Rails.env.test?
      1.year.ago
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2025, 8, 23).in_time_zone('London')
    end
  end

  def self.rm6309_live_at
    if Rails.env.test?
      1.year.ago
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2025, 8, 23).in_time_zone('London')
    end
  end

  def self.rm6309_expires_at
    if Rails.env.test?
      1.year.from_now
    else
      # This is not correct but it is far in the future and we can update it with another migration later on
      Time.new(2028, 8, 23).in_time_zone('London')
    end
  end

  def self.add_frameworks
    ActiveRecord::Base.connection.truncate_tables(:frameworks)
    Framework.create(service: 'supply_teachers', framework: 'RM6238', live_at: Time.new(2022, 9, 12).in_time_zone('London'), expires_at: rm6238_expires_at)
    Framework.create(service: 'management_consultancy', framework: 'RM6187', live_at: Time.new(2021, 9, 4).in_time_zone('London'), expires_at: rm6187_expires_at)
    Framework.create(service: 'legal_services', framework: 'RM6240', live_at: Time.new(2022, 10, 3).in_time_zone('London'), expires_at: rm6240_expires_at)
    Framework.create(service: 'management_consultancy', framework: 'RM6309', live_at: rm6309_live_at, expires_at: rm6309_expires_at)
  end
end

namespace :db do
  desc 'add the frameworks into the database'
  task legacy_frameworks: :environment do
    puts 'Loading Legacy Frameworks'
    DistributedLocks.distributed_lock(157) do
      Frameworks.add_frameworks
    end
  end

  desc 'add static data to the database'
  task static: :legacy_frameworks
end
