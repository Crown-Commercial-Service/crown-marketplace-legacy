module LegalPanelForGovernment::RM6360::SuppliersConcern
  extend ActiveSupport::Concern

  included do
    before_action :fetch_lot
  end

  def fetch_jurisdictions
    @jurisdictions = Jurisdiction.where(id: params[:jurisdiction_ids]).order(:name)
  end

  def fetch_lot
    @lot = Lot.find(params[:lot_id])
  end

  def jurisdiction_ids
    if @lot.id.starts_with?('RM6360.4') && params[:not_core_jurisdiction] == 'yes'
      params[:jurisdiction_ids]
    else
      ['GB']
    end
  end
end
