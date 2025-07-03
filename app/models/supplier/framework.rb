class Supplier < ApplicationRecord
  class Framework < ApplicationRecord
    belongs_to :supplier, inverse_of: :supplier_frameworks
    belongs_to :framework, inverse_of: :supplier_frameworks

    has_one :contact_detail, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::ContactDetail', dependent: :destroy
    has_one :address, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::Address', dependent: :destroy

    has_many :lots, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::Lot', dependent: :destroy
    has_many :branches, inverse_of: :supplier_framework, class_name: 'Supplier::Framework::Branch', dependent: :destroy

    delegate :name, to: :supplier, prefix: true

    def self.with_services_in_jurisdiction(service_ids, jurisdiction_id)
      joins(:supplier, :lots).where(
        enabled: true,
        lots: {
          enabled: true,
          jurisdiction_id: jurisdiction_id,
          id: Supplier::Framework::Lot::Service.where(service_id: service_ids)
                                               .group(:supplier_framework_lot_id)
                                               .having('COUNT(*) = ?', service_ids.length)
                                               .select(:supplier_framework_lot_id)
        }
      ).distinct
    end
  end
end
