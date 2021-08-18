module SupplyTeachers
  class SupplierMarkUp
    include Virtus.model

    attribute :daily_rate, Integer
    attribute :markup_rate, Float

    def worker_cost
      daily_rate / (1 + markup_rate)
    end

    def agency_fee
      daily_rate - worker_cost
    end

    def valid?
      daily_rate.is_a?(Integer) && daily_rate.positive?
    end
  end
end
