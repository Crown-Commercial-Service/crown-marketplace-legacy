module ManagementConsultancy
  module RM6309
    class Journey::ChooseLot
      include Steppable

      attribute :lot
      validates :lot, inclusion: { in: Lot.all_numbers }

      def self.mcf4_lots
        Lot.where(framework: 'MCF4').sort_by { |lot| lot.number[5..].to_i }
      end

      def next_step_class
        Journey::ChooseServices
      end
    end
  end
end
