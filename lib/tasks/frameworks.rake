require_relative 'distributed_locks'

module Frameworks
  def self.add_frameworks
    ActiveRecord::Base.connection.truncate_tables(:frameworks)

    CSV.foreach('data/frameworks.csv', headers: true) do |row|
      Framework.create(id: row['id'], service: row['service'], live_at: Time.parse(row['live_at']).in_time_zone('London'), expires_at: Rails.env.test? ? 1.year.from_now : Time.parse(row['expires_at']).in_time_zone('London'))
    end
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
