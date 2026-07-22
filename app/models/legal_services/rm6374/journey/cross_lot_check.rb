module LegalServices
  module RM6374
    class Journey::CrossLotCheck
      SECTOR_MAPPING = {
        'government_policy' => 'lot_1a',
        'education' => 'lot_1a',
        'defence' => 'lot_1a',
        'infrastructure' => 'lot_1a',
        'culture' => 'lot_1a',
        'transport' => 'lot_1a',
        'local_community' => 'lot_1b',
        'health' => 'lot_1c'
      }.freeze

      def self.get_service_numbers(lot_number)
        Service.where('lot_id LIKE ?', "RM6374.#{lot_number}%")
               .distinct
               .pluck(:number)
               .sort_by(&:to_i)
      end

      def self.evaluate(selected_sector:, selected_specialisms:)
        # check if calling model are coming from lot_1 or lot_2
        recommended_lot = selected_sector.nil? ? 'lot_2' : SECTOR_MAPPING[selected_sector]

        # get all the service numbers for lot_1
        lot_1_services = {
          lot_1a: get_service_numbers('1a'),
          lot_1b: get_service_numbers('1b'),
          lot_1c: get_service_numbers('1c'),
        }

        # check if the selected specialisms are all in each sublot in lot_1, if so, return the sublot as the recommended lot
        alternative_lots = lot_1_services.select do |_name, array|
          (selected_specialisms - array).empty?
        end.keys

        # get all the suppliers for lot_2 with the selected specialisms
        lot_2_suppliers = Supplier::Framework.with_services(selected_specialisms.map { |item| "RM6374.2.#{item}" }).shuffle

        # add lot_2 if it a single suppliers can provide all the selected specialisms and its calling from lot_1
        alternative_lots << 'lot_2' if lot_2_suppliers.present? && !selected_sector.nil?

        # remove the recommended lot from the alternative lots
        remaining_lots = (alternative_lots - [recommended_lot.to_sym]).map(&:to_s)

        {
          recommended_lot: recommended_lot,
          alternatives: remaining_lots
        }
      end
    end
  end
end
