module LegalServices
  module RM6374
    JURISDICTION_MAP = {
      'a' => 'RM6374.EW',
      'b' => 'RM6374.SC',
      'c' => 'RM6374.NI'
    }.freeze

    def self.table_name_prefix
      'legal_services_rm6374_'
    end

    def get_service_numbers(lot_number)
      service_numbers.map do |service_number|
        "RM6374.#{lot_number}.#{service_number}"
      end
    end

    def get_jurisdiction(jurisdiction)
      JURISDICTION_MAP[jurisdiction] || jurisdiction
    end
  end
end
