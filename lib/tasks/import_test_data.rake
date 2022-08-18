module ImportTestData
  module MC
    def self.import_data
      puts 'Importing MC data'

      empty_tables

      File.open('data/management_consultancy/rm6187/dummy_supplier_data.json', 'r') do |file|
        supplier_data = JSON.parse(file.read)
        ManagementConsultancy::RM6187::Upload.upload!(supplier_data)
      end
    end

    def self.empty_tables
      ManagementConsultancy::RM6187::RateCard.destroy_all
      ManagementConsultancy::RM6187::ServiceOffering.destroy_all
      ManagementConsultancy::RM6187::Supplier.destroy_all
    end
  end

  module LS
    def self.import_data
      puts 'Importing LS data'

      empty_tables

      File.open('data/legal_services/rm3788/dummy_supplier_data.json', 'r') do |file|
        supplier_data = JSON.parse(file.read)
        LegalServices::RM3788::Upload.upload!(supplier_data)
      end

      File.open('data/legal_services/rm6240/dummy_supplier_data.json', 'r') do |file|
        supplier_data = JSON.parse(file.read)
        LegalServices::RM6240::Upload.upload!(supplier_data)
      end
    end

    def self.empty_tables
      LegalServices::RM3788::RegionalAvailability.destroy_all
      LegalServices::RM3788::ServiceOffering.destroy_all
      LegalServices::RM3788::Supplier.destroy_all

      LegalServices::RM6240::Rate.destroy_all
      LegalServices::RM6240::ServiceOffering.destroy_all
      LegalServices::RM6240::Supplier.destroy_all
    end
  end

  module ST
    def self.import_data
      puts 'Importing ST data'

      empty_tables

      File.open('data/supply_teachers/rm3826/dummy_supplier_data.json', 'r') do |file|
        supplier_data = JSON.parse(file.read)
        SupplyTeachers::RM3826::Upload.upload!(supplier_data)
      end

      File.open('data/supply_teachers/rm6238/dummy_supplier_data.json', 'r') do |file|
        supplier_data = JSON.parse(file.read)
        SupplyTeachers::RM6238::Upload.upload!(supplier_data)
      end
    end

    def self.empty_tables
      SupplyTeachers::RM3826::Branch.destroy_all
      SupplyTeachers::RM3826::Rate.destroy_all
      SupplyTeachers::RM3826::Supplier.destroy_all

      SupplyTeachers::RM6238::Branch.destroy_all
      SupplyTeachers::RM6238::Rate.destroy_all
      SupplyTeachers::RM6238::ManagedServiceProvider.destroy_all
      SupplyTeachers::RM6238::Supplier.destroy_all
    end
  end
end

namespace :db do
  desc 'Imports test data into the test environment for cucumber tests'
  task import_test_data: :environment do
    if Rails.env.test?
      puts 'Importing the supplier test data'
      ImportTestData::MC.import_data
      ImportTestData::LS.import_data
      ImportTestData::ST.import_data
      puts 'Finished supplier test data import'
    end
  end

  task import_test_data: :static do
  end
end
