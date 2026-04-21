module SupplyTeachers
  module RM6238
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_SKIP_VALIDATION = %i[duns_number sme trading_name additional_identifier].freeze
      end
    end
  end
end
