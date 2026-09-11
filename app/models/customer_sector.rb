class CustomerSector < ApplicationRecord
  has_many :customer_sector_mappings, dependent: :destroy
  has_many :supplier_framework_contact_details, through: :customer_sector_mappings
end