module ManagementConsultancy
  module RM6187
    class Journey::ImportantChanges
      include Steppable

      def next_step_class
        Journey::ChooseLot
      end
    end
  end
end
