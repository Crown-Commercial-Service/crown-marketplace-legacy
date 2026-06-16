module SupplyTeachers
  module RM6238
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_VALIDATE = %i[name].freeze
      end
    end
  end
end
