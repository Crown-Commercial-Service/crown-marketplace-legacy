module LegalServices
  module RM6374
    class Journey::SuppliersComparison
      include Steppable

      attribute :lot_number, :string
      attribute :service_numbers, :array, default: -> { [] }
      attribute :professions, :array, default: -> { [] }
      attribute :jurisdiction, :string

      JURISDICTION_MAP = {
        'a' => 'RM6374.EW',
        'b' => 'RM6374.SC',
        'c' => 'RM6374.NI'
      }.freeze

      def lot
        @lot ||= Lot.find("RM6374.#{lot_number}")
      end

      def selected_jurisdiction_ids
        raw_keys = Array(jurisdiction.presence || 'a').compact_blank
        mapped_ids = raw_keys.map { |key| JURISDICTION_MAP[key] || key }
        mapped_ids[0]
      end

      def supplier_frameworks
        selected_services = service_numbers.map do |service_number|
          "RM6374.#{lot_number}.#{service_number}"
        end

        @supplier_frameworks ||= ::Supplier::Framework.with_lots(lot.id).with_services(selected_services).sort_by(&:supplier_name)
      end

      def supplier_frameworks_with_rates
        @supplier_frameworks_with_rates ||= supplier_frameworks.map do |supplier_framework|
          rates = supplier_framework.grouped_rates_for_lot(
            lot.id,
          ).sort_by { |position_id, _| position_id }.to_h
          [supplier_framework, rates]
        end
      end

      def positions
        positions = [
          ["RM6374.#{lot_number}.1", 'partner'],
          ["RM6374.#{lot_number}.2", 'legal_director'],
          ["RM6374.#{lot_number}.3", 'senior_solicitor'],
          ["RM6374.#{lot_number}.4", 'solicitor'],
          ["RM6374.#{lot_number}.5", 'nq_solicitor'],
          ["RM6374.#{lot_number}.6", 'trainee'],
          ["RM6374.#{lot_number}.7", 'paralegal'],
          ["RM6374.#{lot_number}.8", 'legal_project_manager'],
          ["RM6374.#{lot_number}.9", 'legal_document_reviewer']
        ]

        positions.select do |_code, profession|
          professions.include?(profession)
        end
      end
    end
  end
end
