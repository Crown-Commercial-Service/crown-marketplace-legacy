module LegalServices
  module RM6240
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_SKIP_VALIDATION = [].freeze
      end
    end
  end
end
