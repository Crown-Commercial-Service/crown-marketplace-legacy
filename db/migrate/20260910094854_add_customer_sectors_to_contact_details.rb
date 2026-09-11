class AddCustomerSectorsToContactDetails < ActiveRecord::Migration[7.0]
  def change
    change_table :supplier_framework_contact_details, bulk: true do |t|
      t.boolean :health, default: false
      t.boolean :local_community_and_housing, default: false
      t.boolean :government_policy, default: false
      t.boolean :education, default: false
      t.boolean :defence_and_security, default: false
      t.boolean :infrastructure, default: false
      t.boolean :culture_media_and_sport, default: false
    end
  end
end