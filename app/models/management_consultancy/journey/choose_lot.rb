module ManagementConsultancy
  class Journey::ChooseLot
    include Steppable

    attribute :lot
    attribute :framework
    validates :lot, inclusion: { in: ['MCF3.1', 'MCF3.2', 'MCF3.3', 'MCF3.4', 'MCF3.5', 'MCF3.6', 'MCF3.7', 'MCF3.8', 'MCF3.9'] }

    def self.mcf3_lots
      Lot.where(framework: 'MCF3').sort_by(&:number)
    end

    def next_step_class
      Journey::ChooseServices
    end
  end
end
