class Search < ApplicationRecord
  belongs_to :user, inverse_of: :searches
  belongs_to :framework, inverse_of: :searches

  serialize :search_criteria, type: Hash, coder: YAML
  serialize :search_result, type: Array, coder: YAML

  def self.log_new_search(framework, user, session_id, search_criteria, search_result)
    sanatized_search_criteria = sanatize_search_criteria(search_criteria)
    sanatized_search_criteria_hash = Digest::SHA256.hexdigest(sanatized_search_criteria.to_s)

    return false if find_by(framework_id: framework.id, user_id: user.id, session_id: session_id, search_criteria_hash: sanatized_search_criteria_hash)

    create!(
      framework_id: framework.id,
      user_id: user.id,
      session_id: session_id,
      search_criteria: sanatized_search_criteria,
      search_criteria_hash: sanatized_search_criteria_hash,
      search_result: search_result.map { |supplier_framework| [supplier_framework.supplier.name, supplier_framework.supplier.id] }
    )
  end

  # rubocop:disable Style/HashTransformValues
  def self.sanatize_search_criteria(search_criteria)
    search_criteria.sort.reject { |_key, value| value != false && value.blank? }.to_h { |key, value| [key, value.is_a?(Array) ? value.sort : value] }
  end
  # rubocop:enable Style/HashTransformValues
end
