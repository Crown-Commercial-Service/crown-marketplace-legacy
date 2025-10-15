class LegalPanelForGovernment::RM6360::SuppliersSelector
  attr_reader :service_ids, :jurisdiction_ids

  def initialize(lot_id:, service_ids:, not_core_jurisdiction:, jurisdiction_ids:)
    @service_ids = service_ids
    @jurisdiction_ids = if lot_id.starts_with?('RM6360.4') && not_core_jurisdiction == 'yes'
                          jurisdiction_ids
                        else
                          ['GB']
                        end
  end

  def supplier_frameworks
    @supplier_frameworks ||= Supplier::Framework.with_services_and_jurisdiction(service_ids, jurisdiction_ids).includes(:supplier).order('supplier.name')
  end
end
