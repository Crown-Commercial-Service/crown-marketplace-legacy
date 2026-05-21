module LegalPanelForGovernment
  module RM6360
    module Admin
      class ChangeJurisdictions
        include ActiveModel::Model

        ADD_OR_REMOVE_OPTIONS = %w[add remove].freeze

        attr_reader :jurisdiction_lists

        attr_accessor :add_or_remove, :jurisdiction_to_add, :jurisdiction_to_remove

        validates :add_or_remove, inclusion: ADD_OR_REMOVE_OPTIONS
        validate :jurisdiction_to_add_in_list, if: -> { add_or_remove == 'add' }
        validate :jurisdiction_to_remove_in_list, if: -> { add_or_remove == 'remove' }

        def initialize(jurisdiction_ids:, **)
          super(**)

          @jurisdiction_lists = {
            'add' => Jurisdiction.non_core.where.not(id: jurisdiction_ids).order(:name),
            'remove' => Jurisdiction.non_core.where(id: jurisdiction_ids).order(:name)
          }
        end

        private

        ADD_OR_REMOVE_OPTIONS.each do |option|
          define_method(:"jurisdiction_to_#{option}_in_list") { errors.add(:"jurisdiction_to_#{option}", :inclusion) unless jurisdiction_lists[option].pluck(:id).include?(public_send("jurisdiction_to_#{option}")) }
        end
      end
    end
  end
end
