module ManagementConsultancy
  class Journey::ChooseLot
    include Steppable

    attribute :lot
    attribute :framework
    validates :lot, inclusion: { in: ['MCF1.2', 'MCF1.3', 'MCF2.3', 'MCF1.4', 'MCF1.5', 'MCF1.6', 'MCF1.7', 'MCF1.8', 'MCF2.1', 'MCF2.2', 'MCF2.3', 'MCF2.4'] }, unless: -> { Marketplace.mcf3_live? }
    validates :lot, inclusion: { in: ['MCF3.1', 'MCF3.2', 'MCF3.3', 'MCF3.4', 'MCF3.5', 'MCF3.6', 'MCF3.7', 'MCF3.8', 'MCF3.9'] }, if: -> { Marketplace.mcf3_live? }

    def self.mcf_lots
      Lot.where(framework: 'MCF').sort_by(&:number)
    end

    def self.mcf2_lots
      Lot.where(framework: 'MCF2').sort_by(&:number)
    end

    def self.mcf3_lots
      Lot.where(framework: 'MCF3').sort_by(&:number)
    end

    def next_step_class
      Journey::ChooseServices
    end
  end
end
