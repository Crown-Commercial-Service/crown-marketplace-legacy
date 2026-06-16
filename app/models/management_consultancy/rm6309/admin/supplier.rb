module ManagementConsultancy
  module RM6309
    module Admin
      class Supplier < ::Supplier
        self.table_name = 'suppliers'

        ATTRIBUTES_TO_VALIDATE = %i[name duns_number sme].freeze
      end
    end
  end
end
