module ImportTestData
  module MC
    module RM6187
      def self.import_data
        puts 'Importing MC RM6187 data'

        File.open('data/management_consultancy/rm6187/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6187', JSON.parse(file.read, symbolize_names: true))
        end

        puts 'Making RM6187 (MCF3) live'
        Framework.find('RM6187').update(expires_at: 1.day.from_now)
      end
    end

    module RM6309
      def self.import_data
        puts 'Importing MC RM6309 data'

        File.open('data/management_consultancy/rm6309/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6309', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  module LS
    module RM6240
      def self.import_data
        puts 'Importing LS RM6240 data'

        File.open('data/legal_services/rm6240/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6240', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  module ST
    module RM6238
      def self.import_data
        puts 'Importing ST RM6238 data'

        File.open('data/supply_teachers/rm6238/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6238', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  def self.empty_tables
    ActiveRecord::Base.connection.truncate_tables(
      :suppliers,
      :supplier_frameworks,
      :supplier_framework_lots,
      :supplier_framework_contact_details,
      :supplier_framework_addresses,
      :supplier_framework_lot_jurisdictions,
      :supplier_framework_lot_services,
      :supplier_framework_lot_rates,
      :supplier_framework_lot_branches,
    )
  end

  def self.import_test_data
    empty_tables

    MC::RM6187.import_data
    MC::RM6309.import_data
    LS::RM6240.import_data
    ST::RM6238.import_data
  end

  def self.import_test_data_for_framework_service(framework)
    empty_tables

    case framework
    when 'RM6187', 'RM6309'
      MC::RM6187.import_data
      MC::RM6309.import_data
    when 'RM6240'
      LS::RM6240.import_data
    when 'RM6238'
      ST::RM6238.import_data
    end
  end
end

namespace :db do
  desc 'Imports test data into the test environment for cucumber tests'
  task import_test_data: :environment do
    if Rails.env.test?
      puts 'Importing the supplier test data'
      ImportTestData.import_test_data
      puts 'Finished supplier test data import'
    end
  end

  desc 'Imports test data for a specific framework into the test environment for cucumber tests'
  task :import_test_data_for_framework_service, [:framework] => :environment do |_t, args|
    if Rails.env.test?
      puts "Importing the supplier test data for #{args[:framework]}"
      ImportTestData.import_test_data_for_framework_service(args[:framework])
      puts "Finished supplier test data import for #{args[:framework]}"
    end
  end

  desc 'Imports test data into the development environment'
  task import_test_data_to_development: :environment do
    if Rails.env.development?
      puts 'Importing the supplier test data to development'
      ImportTestData.import_test_data
      puts 'Finished supplier test data import'
    end
  end

  task import_test_data: :static
  task import_test_data_for_framework_service: :static
end
