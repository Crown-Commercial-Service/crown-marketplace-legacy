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

        def available_suppliers
          selected_services = get_service_numbers(lot_number)
          selected_jurisdiction_id = get_jurisdiction(jurisdiction)

          ::Supplier::Framework.with_lots(lot.id)
                               .with_services_and_jurisdiction(selected_services, [selected_jurisdiction_id])
                               .sort_by(&:supplier_name)
        end

        def next_step_class
          Journey::SuppliersComparison
        end
      end
    end
  end
end
