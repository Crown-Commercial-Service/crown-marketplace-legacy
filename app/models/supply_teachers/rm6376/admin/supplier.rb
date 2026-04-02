module SupplyTeachers
  module RM6376
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_SKIP_VALIDATION = %i[duns_number sme].freeze
      end
    end
  end
end
