module LegalServices
  module RM3788
    class Journey::ChooseRegions
      include Steppable

      attribute :region_codes, Array
      validates :region_codes, length: { minimum: 1 }
      validate :full_national_coverage_or_selected_regions

      def lot(lot_number)
        LegalServices::RM3788::Lot.find_by(number: lot_number)
      end

      def next_step_class
        Journey::Suppliers
      end

      def full_national_coverage_or_selected_regions
        return true unless region_codes.include?('UK')

        return true if region_codes == ['UK']

        errors.add(:region_codes, :full_national_coverage)
      end
    end
  end
end
