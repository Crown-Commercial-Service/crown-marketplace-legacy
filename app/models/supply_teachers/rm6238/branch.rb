module SupplyTeachers
  module RM6238
    class Branch < SupplyTeachers::Branch
      extend FriendlyId

      friendly_id :supplier_name, use: :slugged

      belongs_to :supplier,
                 foreign_key: :supply_teachers_rm6238_supplier_id,
                 inverse_of: :branches

      def self.search(point, rates:, radius:)
        metres = DistanceConverter.miles_to_metres(radius)
        Branch.includes(:supplier)
              .near(point, within_metres: metres)
              .joins(supplier: [:rates])
              .merge(rates)
              .order(Rate.arel_table[:rate].asc)
              .order(Arel.sql("ST_Distance(location, '#{point}')"))
      end
    end
  end
end
