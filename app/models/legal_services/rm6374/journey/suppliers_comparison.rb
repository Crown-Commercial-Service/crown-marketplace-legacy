module LegalServices
  module RM6374
    class Journey::SuppliersComparison
      include LegalServices::RM6374
      include Steppable

      attribute :lot_number, :string
      attribute :service_numbers, :array, default: -> { [] }
      attribute :supplier_framework_ids, :array, default: -> { [] }
      attribute :professions, :array, default: -> { [] }
      attribute :jurisdiction, :string

      def lot
        @lot ||= Lot.find("RM6374.#{lot_number}")
      end

      def supplier_frameworks
        selected_services = get_service_numbers(lot_number)
        selected_jurisdiction_id = get_jurisdiction(jurisdiction)

        @supplier_frameworks ||= begin
          scope = ::Supplier::Framework.with_lots(lot.id)
                                       .with_services_and_jurisdiction(selected_services, [selected_jurisdiction_id])
          scope = scope.where(id: supplier_framework_ids) if supplier_framework_ids.present?

          scope.sort_by(&:supplier_name)
        end
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
