class SanatizeSearchCriteria < ActiveRecord::Migration[8.0]
  class Searches < ApplicationRecord
    self.table_name = 'searches'

    serialize :search_criteria, type: Hash, coder: YAML
  end

  def up
    Searches.find_each do |search|
      # rubocop:disable Style/HashTransformValues
      sanatized_search_criteria = search.search_criteria.sort.reject { |_key, value| value != false && value.blank? }.to_h { |key, value| [key, value.is_a?(Array) ? value.sort : value] }
      # rubocop:enable Style/HashTransformValues
      sanatized_search_criteria_hash = Digest::SHA256.hexdigest(sanatized_search_criteria.to_s)

      search.update(search_criteria: sanatized_search_criteria, search_criteria_hash: sanatized_search_criteria_hash)
    end
  end

  def down; end
end
