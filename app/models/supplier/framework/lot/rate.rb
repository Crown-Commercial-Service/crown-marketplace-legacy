class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    class Lot < ApplicationRecord
      class Rate < ApplicationRecord
        belongs_to :supplier_framework_lot, inverse_of: :rates, class_name: 'Supplier::Framework::Lot'
        belongs_to :position, inverse_of: :supplier_framework_lot_rates
        belongs_to :jurisdiction, inverse_of: :rates, class_name: 'Supplier::Framework::Lot::Jurisdiction', foreign_key: :supplier_framework_lot_jurisdiction_id

        with_options on: %i[rates] do
          validates :rate, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
          validates :rate, numericality: { less_than: 10000, message: :less_than_100 }, if: -> { rate_type == 'percentage' }
          validates :rate, numericality: { less_than: 100000000, message: :less_than_1000000 }, if: -> { rate_type == 'money' }
        end

        delegate :rate_type, to: :position
        delegate :mandatory, to: :position

        def normalized_rate
          rate / 100.0
        end

        def rate_as_percentage_decimal
          rate / 10000.0
        end

        def assign_rate_and_validate?(rate)
          rate = rate.to_s

          if rate == ''
            self.rate = nil

            return true unless mandatory
          elsif (rate_type == 'percentage' && rate.match?(PERCENTAGE_REGEX)) || (rate_type == 'money' && rate.match?(MONEY_REGEX))
            self.rate = conver_rate_string_to_integer(rate)
          else
            self.rate = nil

            errors.add(:rate, :"invalid_format_#{rate_type}")

            return false
          end

          valid?(:rates)
        end

        private

        def conver_rate_string_to_integer(rate_as_string)
          integer_part, decimal_part = rate_as_string.split('.')

          decimal_part ||= ''

          "#{integer_part}#{decimal_part[0] || '0'}#{decimal_part[1] || '0'}".to_i
        end

        MONEY_REGEX = /\A[1-9]\d*\z|\A[1-9]\d*\.\d{2}\z|\A0.\d{2}\z|\A0\z/
        PERCENTAGE_REGEX = /\A[1-9]\d*\z|\A[1-9]\d*\.\d{1}\z|\A0.\d{1}\z|\A0\z/
      end
    end
  end
end
