class CustomerSectorMapping < ApplicationRecord
  belongs_to :supplier_framework_contact_detail, class_name: 'Supplier::Framework::ContactDetail'
  belongs_to :customer_sector
end