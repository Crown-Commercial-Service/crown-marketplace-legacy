module ManagementConsultancy
  module RM6309
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_SKIP_VALIDATION = %i[trading_name additional_identifier].freeze
      end
    end
  end
end
