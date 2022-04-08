module ImportTestData
  module MC
    def self.import_data
      empty_tables

      File.open('data/management_consultancy/dummy_supplier_data.json', 'r') do |file|
        supplier_data = JSON.parse(file.read)
        ManagementConsultancy::Upload.upload!(supplier_data)
      end
    end

    def self.empty_tables
      ManagementConsultancy::RateCard.destroy_all
      ManagementConsultancy::ServiceOffering.destroy_all
      ManagementConsultancy::Supplier.destroy_all
    end
  end
end

namespace :db do
  desc 'Imports test data into the test environment for cucumber tests'
  task import_test_data: :environment do
    if Rails.env.test?
      puts 'Importing the supplier test data'
      ImportTestData::MC.import_data
      puts 'Finished supplier test data import'
    end
  end

  task import_test_data: :static do
  end
end
