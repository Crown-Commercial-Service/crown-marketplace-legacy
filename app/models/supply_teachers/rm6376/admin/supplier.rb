module SupplyTeachers
  module RM6376
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_VALIDATE = %i[name trading_name additional_identifier].freeze
      end
    end
  end
end
