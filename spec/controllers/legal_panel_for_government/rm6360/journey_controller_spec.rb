require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::JourneyController do
  let(:default_params) { { service: 'legal_panel_for_government', framework: framework } }
  let(:framework) { 'RM6360' }
  let(:supplier_framework) { create(:supplier_framework) }
  let(:supplier_framework_records) { create_list(:supplier_framework, 3, framework_id: framework) }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework_records.map(&:id)).includes(:supplier).order('supplier.name') }
  let(:lot_id) { 'RM6360.1' }
  let(:lot) { Lot.find(lot_id) }
  let(:services) { Service.where(lot_id:).sample(5) }
  let(:service_ids) { services.map(&:id) }
  let(:central_government) { 'yes' }
  let(:jurisdiction_ids) { ['GB'] }
  let(:requirement_start_date_day) { '1' }
  let(:requirement_start_date_month) { '10' }
  let(:requirement_start_date_year) { '2025' }
  let(:requirement_end_date_day) { '1' }
  let(:requirement_end_date_month) { '10' }
  let(:requirement_end_date_year) { '2026' }
  let(:requirement_estimated_total_value) { '123456' }
  let(:ccs_can_contact_you) { 'yes' }

  let(:params) do
    {
      lot_id:,
      service_ids:,
      central_government:,
      requirement_start_date_day:,
      requirement_start_date_month:,
      requirement_start_date_year:,
      requirement_end_date_day:,
      requirement_end_date_month:,
      requirement_end_date_year:,
      requirement_estimated_total_value:,
      ccs_can_contact_you:,
    }
  end

  login_ls_buyer_with_details

  describe 'GET question' do
    before do
      allow(Supplier::Framework).to receive(:with_services_and_jurisdiction).with(service_ids, jurisdiction_ids).and_return(supplier_frameworks)
      allow(Search).to receive(:log_new_search).and_return(true)

      get :question, params:
    end

    it 'sets the journey' do
      expect(assigns(:journey).current_step.class).to eq(LegalPanelForGovernment::RM6360::Journey::SupplierResults)
    end

    it 'logs the search' do
      expect(Search).to have_received(:log_new_search).with(lot.framework, controller.current_user, controller.session.id, { central_government:, lot_id:, service_ids:, requirement_start_date_day:, requirement_start_date_month:, requirement_start_date_year:, requirement_end_date_day:, requirement_end_date_month:, requirement_end_date_year:, requirement_estimated_total_value:, ccs_can_contact_you: }.stringify_keys, supplier_frameworks)
    end
  end
end
