require_relative 'distributed_locks'

module Frameworks
  def self.remove_framework_tables
    ActiveRecord::Base.connection.truncate_tables(:frameworks, :framework_lots, :framework_lot_services)
  end

  def self.add_frameworks
    CSV.foreach('data/frameworks.csv', headers: true) do |row|
      Framework.create!(
        **row,
        live_at: Time.parse(row['live_at']).in_time_zone('London'),
        expires_at: Rails.env.test? ? 1.year.from_now : Time.parse(row['expires_at']).in_time_zone('London')
      )
    end
  end

  def self.add_framework_lots
    CSV.foreach('data/frameworks/lots.csv', headers: true) do |row|
      Framework::Lot.create!(
        id: "#{row['framework_id']}_#{row['number']}",
        **row
      )
    end
  end

  def self.add_framework_lot_services
    CSV.foreach('data/frameworks/lots/services.csv', headers: true) do |row|
      Framework::Lot::Service.create!(
        id: "#{row['framework_id']}_#{row['framework_lot_number']}_#{row['number']}",
        framework_lot_id: "#{row['framework_id']}_#{row['framework_lot_number']}",
        **row.to_h.except('framework_id', 'framework_lot_number')
      )
    end
  end
end

namespace :db do
  desc 'add the frameworks into the database'
  task frameworks: :environment do
    puts 'Loading Frameworks'
    DistributedLocks.distributed_lock(157) do
      Frameworks.remove_framework_tables
      Frameworks.add_frameworks
      Frameworks.add_framework_lots
      Frameworks.add_framework_lot_services
    end
  end

  desc 'add static data to the database'
  task static: :frameworks
end
