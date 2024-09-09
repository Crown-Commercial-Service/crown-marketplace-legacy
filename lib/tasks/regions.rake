require_relative 'distributed_locks'

module Regions
  def self.add_regions
    ActiveRecord::Base.connection.truncate_tables(:regions)

    CSV.foreach('data/regions.csv', headers: true) do |row|
      Region.create(**row)
    end
  end
end

namespace :db do
  desc 'add the regions into the database'
  task regions: :environment do
    puts 'Loading Regions'
    DistributedLocks.distributed_lock(158) do
      Regions.add_regions
    end
  end

  desc 'add static data to the database'
  task static: :regions
end
