class RemoveOldCustomerSectors < ActiveRecord::Migration[8.1]
  def change
    remove_column :supplier_framework_contact_details, :health, :boolean
    remove_column :supplier_framework_contact_details, :local_community_and_housing, :boolean
    remove_column :supplier_framework_contact_details, :government_policy, :boolean
    remove_column :supplier_framework_contact_details, :education, :boolean
    remove_column :supplier_framework_contact_details, :defence_and_security, :boolean
    remove_column :supplier_framework_contact_details, :infrastructure, :boolean
    remove_column :supplier_framework_contact_details, :culture_media_and_sport, :boolean
  end
end