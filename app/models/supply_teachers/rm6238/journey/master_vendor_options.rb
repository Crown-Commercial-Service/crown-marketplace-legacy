module SupplyTeachers
  module RM6238
    class Journey::MasterVendorOptions
      include Steppable

      THRESHOLD_POSITIONS = %w[above_threshold below_threshold].freeze

      attribute :threshold_position
      validates :threshold_position, inclusion: THRESHOLD_POSITIONS

      def next_step_class
        Journey::MasterVendors
      end
    end
  end
end
