class DataLoader::TestData
  module MC
    module RM6187
      def self.import_data
        Rails.logger.info 'Importing MC RM6187 data'

        File.open('data/management_consultancy/rm6187/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6187', JSON.parse(file.read, symbolize_names: true))
        end

        Rails.logger.info 'Making RM6187 (MCF3) live'
        Framework.find('RM6187').update(expires_at: 1.day.from_now)
      end
    end

    module RM6309
      def self.import_data
        Rails.logger.info 'Importing MC RM6309 data'

        File.open('data/management_consultancy/rm6309/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6309', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  module LS
    module RM6240
      def self.import_data
        Rails.logger.info 'Importing LS RM6240 data'

        File.open('data/legal_services/rm6240/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6240', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  module LPG
    module RM6360
      def self.import_data
        Rails.logger.info 'Importing LPG RM6360 data'

        File.open('data/legal_panel_for_government/rm6360/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6360', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  module ST
    module RM6238
      def self.import_data
        Rails.logger.info 'Importing ST RM6238 data'

        File.open('data/supply_teachers/rm6238/dummy_supplier_data.json', 'r') do |file|
          Upload.upload!('RM6238', JSON.parse(file.read, symbolize_names: true))
        end
      end
    end
  end

  class << self
    private

    def empty_tables
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

    public

    def import_test_data
      empty_tables

      MC::RM6187.import_data
      MC::RM6309.import_data
      LS::RM6240.import_data
      LPG::RM6360.import_data
      ST::RM6238.import_data
    end

    def import_test_data_for_framework_service(framework)
      empty_tables

      case framework
      when 'RM6187', 'RM6309'
        MC::RM6187.import_data
        MC::RM6309.import_data
      when 'RM6240'
        LS::RM6240.import_data
      when 'RM6360'
        LPG::RM6360.import_data
      when 'RM6238'
        ST::RM6238.import_data
      end
    end
  end
end
