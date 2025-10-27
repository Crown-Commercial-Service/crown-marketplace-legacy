class AddAdditionalDetailsToSearch < ActiveRecord::Migration[8.0]
  def change
    change_table :searches, bulk: true do |t|
      t.text :search_criteria_hash
      t.jsonb :additional_details
    end
  end
end
