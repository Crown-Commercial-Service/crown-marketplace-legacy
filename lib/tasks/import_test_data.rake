module ImportTestData
  module MC
    module RM6187
      def self.import_data
        puts 'Importing MC RM6187 data'

        empty_tables

        File.open('data/management_consultancy/rm6187/dummy_supplier_data.json', 'r') do |file|
          supplier_data = JSON.parse(file.read)
          ManagementConsultancy::RM6187::Upload.upload!(supplier_data)
        end

        puts 'Making RM6187 (MCF3) live'
        Framework.find_by(framework: 'RM6187').update(expires_at: 1.day.from_now)
      end

      def self.empty_tables
        ManagementConsultancy::RM6187::RateCard.destroy_all
        ManagementConsultancy::RM6187::ServiceOffering.destroy_all
        ManagementConsultancy::RM6187::Supplier.destroy_all
      end
    end

    module RM6309
      def self.import_data
        puts 'Importing MC RM6309 data'

        empty_tables

        File.open('data/management_consultancy/rm6309/dummy_supplier_data.json', 'r') do |file|
          supplier_data = JSON.parse(file.read)
          ManagementConsultancy::RM6309::Upload.upload!(supplier_data)
        end
      end

      def self.empty_tables
        ManagementConsultancy::RM6309::RateCard.destroy_all
        ManagementConsultancy::RM6309::LotContactDetail.destroy_all
        ManagementConsultancy::RM6309::ServiceOffering.destroy_all
        ManagementConsultancy::RM6309::Supplier.destroy_all
      end
    end
  end

  module LS
    module RM6240
      def self.import_data
        puts 'Importing LS RM6240 data'

        empty_tables

        File.open('data/legal_services/rm6240/dummy_supplier_data.json', 'r') do |file|
          supplier_data = JSON.parse(file.read)
          LegalServices::RM6240::Upload.upload!(supplier_data)
        end
      end

      def self.empty_tables
        LegalServices::RM6240::Rate.destroy_all
        LegalServices::RM6240::ServiceOffering.destroy_all
        LegalServices::RM6240::Supplier.destroy_all
      end
    end
  end

  module ST
    module RM6238
      def self.import_data
        puts 'Importing ST RM6238 data'

        empty_tables

        File.open('data/supply_teachers/rm6238/dummy_supplier_data.json', 'r') do |file|
          supplier_data = JSON.parse(file.read)
          SupplyTeachers::RM6238::Upload.upload!(supplier_data)
        end
      end

      def self.empty_tables
        SupplyTeachers::RM6238::Branch.destroy_all
        SupplyTeachers::RM6238::Rate.destroy_all
        SupplyTeachers::RM6238::ManagedServiceProvider.destroy_all
        SupplyTeachers::RM6238::Supplier.destroy_all
      end
    end
  end
end

namespace :db do
  desc 'Imports test data into the test environment for cucumber tests'
  task import_test_data: :environment do
    if Rails.env.test?
      puts 'Importing the supplier test data'
      ImportTestData::MC::RM6187.import_data
      ImportTestData::MC::RM6309.import_data
      ImportTestData::LS::RM6240.import_data
      ImportTestData::ST::RM6238.import_data
      puts 'Finished supplier test data import'
    end
  end

  task import_test_data: :static
end
