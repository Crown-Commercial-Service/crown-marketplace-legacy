module LegalServices
  module RM6374
    class Journey::SuppliersComparison
      include Steppable

      attribute :lot_number, :string
      attribute :supplier_framework_ids, array: true, default: []
      attribute :supplier_ids, array: true, default: []

      def lot
        @lot ||= Lot.find("RM6374.#{lot_number}")
      end

      def supplier_frameworks
        @supplier_frameworks ||= begin
          records = ::Supplier::Framework.with_lots(lot.id)

          selected_ids = (supplier_framework_ids + supplier_ids).reject(&:blank?)
          records = records.where(id: selected_ids) if selected_ids.present?

          records.sort_by(&:supplier_name).map do |supplier_framework|
            rates_list = supplier_framework.try(:supplier_rates) || supplier_framework.try(:rates) || []
            rates_filtered = rates_list.respond_to?(:where) ? rates_list.where(lot_number: lot_number) : rates_list.select { |r| r.try(:lot_number).to_s == lot_number.to_s }
            rates_hash = rates_filtered.index_by(&:position_id)

            [supplier_framework, rates_hash]
          end
        end
      end
    end
  end
end