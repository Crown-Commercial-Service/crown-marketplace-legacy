module LegalServices
  module RM6374
    class Journey::DirectCompetition
      include Steppable

      attribute :lot_number, :string
      attribute :call_off_mechanism, :string

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def supplier_frameworks(params)
        service_numbers = Array(params[:service_numbers]).reject(&:blank?)
        return [] if service_numbers.empty?

        service_codes = service_numbers.map { |service_number| "#{lot.id}.#{service_number}" }
        Supplier::Framework.with_services(service_codes)
      end

      def next_step_class
        nil
      end
    end
  end
end