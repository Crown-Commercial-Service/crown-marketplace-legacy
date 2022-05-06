module SupplyTeachers
  module RM3826
    class Term
      include StaticRecord

      attr_accessor :code, :description, :rate_term
    end

    Term.load_csv('supply_teachers/rm3826/terms.csv')
  end
end
