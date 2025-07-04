module ManagementConsultancy
  class Journey::ChooseLot
    include Steppable

    attribute :lot_id
    validates :lot_id, presence: true

    def self.lots
      Lot.where(framework_id: framework).sort_by { |lot| lot.number.to_i }
    end

    def next_step_class
      service_name::Journey::ChooseServices
    end
  end
end
