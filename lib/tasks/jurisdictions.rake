require 'csv'

module Jurisdictions
  def self.add_jurisdictions
    ActiveRecord::Base.connection.truncate_tables(:jurisdictions)

    jurisdictions_file_name = Rails.root.join('data', 'jurisdictions.csv')

    CSV.read(jurisdictions_file_name, headers: true).each do |row|
      Jurisdiction.create(**row)
    end
  end
end

namespace :db do
  desc 'add the jurisdictions into the database'
  task jurisdictions: :environment do
    puts 'Loading Jurisdictions'
    DistributedLocks.distributed_lock(158) do
      Jurisdictions.add_jurisdictions
    end
  end

  desc 'add static data to the database'
  task static: :jurisdictions
end
