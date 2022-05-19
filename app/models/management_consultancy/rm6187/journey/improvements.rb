module ManagementConsultancy
  module RM6187
    class Journey::Improvements
      include Steppable

      def next_step_class
        Journey::ChooseLot
      end
    end
  end
end
