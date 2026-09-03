module LegalServices
  module RM6374
    module Journey
      class CompareSelectSuppliers
        include LegalServices::RM6374
        include Steppable

        attribute :lot_number, :string
        attribute :jurisdiction, :string
        attribute :service_numbers, :array, default: -> { [] }
        attribute :professions, :array, default: -> { [] }
        attribute :supplier_framework_ids, :array, default: -> { [] }

        validates :supplier_framework_ids, length: { minimum: 1 }

        def lot
          Lot.find("RM6374.#{lot_number}")
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
          all_positions = lot.positions.order(:number).pluck(:id, :name)

          return all_positions if professions.blank? || professions.include?('all')

          all_positions.select do |position_id, profession_name|
            professions.include?(profession_name) || professions.include?(position_id)
          end
        end

        def next_step_class
          Journey::SuppliersComparison
        end

        private

        def supplier_frameworks
          selected_services = get_service_numbers(lot_number)

          @supplier_frameworks ||= if lot_number == '6'
                                     fetch_lot_6_supplier_frameworks(selected_services)
                                   else
                                     fetch_standard_supplier_frameworks(selected_services)
                                   end
        end

        def fetch_lot_6_supplier_frameworks(selected_services)
          scope = ::Supplier::Framework.with_lots(lot.id).with_services(selected_services)
          scope = scope.where(id: supplier_framework_ids) if supplier_framework_ids.present?
          scope.sort_by(&:supplier_name)
        end

        def fetch_standard_supplier_frameworks(selected_services)
          selected_jurisdiction_id = get_jurisdiction(jurisdiction)
          scope = ::Supplier::Framework.with_lots(lot.id)
                                       .with_services_and_jurisdiction(selected_services, [selected_jurisdiction_id])
          scope = scope.where(id: supplier_framework_ids) if supplier_framework_ids.present?
          scope.sort_by(&:supplier_name)
        end
      end
    end
  end
end
