require 'csv'

module Frameworks
  # rubocop:disable Metrics/AbcSize
  def self.framework_with_transformed_dates(framework)
    framework['live_at'] = Time.new(*framework['live_at'].split('-')).in_time_zone('London')
    framework['expires_at'] = Time.new(*framework['expires_at'].split('-')).in_time_zone('London')

    if Rails.env.test?
      case framework['id']
      when 'RM6238', 'RM6240'
        framework['expires_at'] = 1.year.from_now
      when 'RM6187'
        framework['expires_at'] = 1.year.ago
      when 'RM6309'
        framework['live_at'] = 1.year.ago
        framework['expires_at'] = 1.year.from_now
      end
    end

    framework
  end
  # rubocop:enable Metrics/AbcSize

  def self.add_frameworks
    ActiveRecord::Base.connection.truncate_tables(:frameworks, :lots, :services)

    frameworks_file_name = Rails.root.join('data', 'frameworks.csv')
    lots_file_name = Rails.root.join('data', 'lots.csv')
    services_file_name = Rails.root.join('data', 'services.csv')

    CSV.read(frameworks_file_name, headers: true).each do |row|
      Framework.create(**framework_with_transformed_dates(row))
    end

    CSV.read(lots_file_name, headers: true).each do |row|
      Lot.create(**row)
    end

    CSV.read(services_file_name, headers: true).each do |row|
      Service.create(**row)
    end
  end
end

namespace :db do
  desc 'add the frameworks into the database'
  task frameworks: :environment do
    puts 'Loading Frameworks'
    DistributedLocks.distributed_lock(157) do
      Frameworks.add_frameworks
    end
  end

  desc 'add static data to the database'
  task static: :frameworks
end
