module LegalServices
  module RM6374
    module Journey
      class CompareSelectSuppliers
        include LegalServices::RM6374
        include LegalServices::RM6374::Admin::SuppliersHelper
        include Steppable

        attribute :sector, :string
        attribute :lot_number, :string
        attribute :jurisdiction, :string
        attribute :call_off_mechanism, :string
        attribute :service_numbers, :array, default: -> { [] }
        attribute :professions, :array, default: -> { [] }
        attribute :supplier_framework_ids, :array, default: -> { [] }

        validate :validate_supplier_framework_ids_count

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

        NUM_TO_WORDS = { 1 => 'one', 3 => 'three' }.freeze

        def validate_supplier_framework_ids_count
          selected_suppliers = supplier_framework_ids.compact_blank.length
          base_min = call_off_mechanism == 'quotation_process' ? 3 : 1

          if selected_suppliers.zero?
            errors.add(:supplier_framework_ids, 'Please select a minimum of one supplier for comparison')
            return
          end

          available_suppliers = @supplier_frameworks&.length || selected_suppliers
          min_required = [base_min, available_suppliers].min

          return if selected_suppliers >= min_required

          errors.add(:supplier_framework_ids, 'Please select a minimum of three suppliers for comparison')
        end

        def supplier_frameworks
          selected_services = get_service_numbers(lot_number)

          @supplier_frameworks ||= if lot_number == '6'
                                     fetch_lot_6_supplier_frameworks(selected_services)
                                   else
                                     fetch_standard_supplier_frameworks(selected_services)
                                   end
        end

        def fetch_lot_6_supplier_frameworks(selected_services)
          selected_sector_id = sector_id_for(sector)

          ::Supplier::Framework.with_lots(lot.id)
                               .with_services(selected_services)
                               .with_sector(selected_sector_id)
                               .sort_by(&:supplier_name)
        end

        def fetch_standard_supplier_frameworks(selected_services)
          selected_sector_id = sector_id_for(sector)
          selected_jurisdiction_id = get_jurisdiction(jurisdiction)
          ::Supplier::Framework.with_lots(lot.id)
                               .with_services_and_jurisdiction(selected_services, [selected_jurisdiction_id])
                               .with_sector(selected_sector_id)
                               .sort_by(&:supplier_name)
        end
      end
    end
  end
end
