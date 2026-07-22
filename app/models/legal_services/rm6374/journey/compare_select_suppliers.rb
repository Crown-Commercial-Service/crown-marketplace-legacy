module LegalServices
  module RM6374
    module Journey
      class CompareSelectSuppliers
        include Steppable

        attribute :lot_number, :string
        attribute :supplier_framework_ids, :array, default: -> { [] }

        validates :supplier_framework_ids, length: { minimum: 1 }

        def lot
          Lot.find("RM6374.#{lot_number}")
        end

        def available_suppliers
          Supplier::Framework::Lot.where(lot_id: lot.id)
                                  .includes(supplier_framework: :supplier)
                                  .map(&:supplier_framework)
                                  .uniq
                                  .sort_by { |sf| sf.supplier.name }
        end
      end
    end
  end
end
