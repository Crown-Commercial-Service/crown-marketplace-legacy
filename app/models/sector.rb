class Sector < ApplicationRecord
  has_many :supplier_framework_sectors,
           class_name: 'Supplier::Framework::Sector',
           dependent: :destroy

  has_many :supplier_frameworks,
           through: :supplier_framework_sectors,
           source: :supplier_framework

  validates :name, presence: true, uniqueness: true
end
