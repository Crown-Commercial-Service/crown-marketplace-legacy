class AddIndexForSearches < ActiveRecord::Migration[8.0]
  def change
    add_index :searches, %i[framework_id user_id session_id search_criteria_hash]
  end
end
