require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::SuppliersController do
  let(:default_params) { { service: 'legal_panel_for_government', framework: framework } }
  let(:framework) { 'RM6360' }
  let(:supplier_framework) { create(:supplier_framework) }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework.id) }
  let(:lot) { Lot.find(lot_id) }
  let(:services) { Service.where(lot_id:).sample(5) }
  let(:service_ids) { services.map(&:id) }
  let(:central_government) { 'yes' }
  let(:jurisdiction_ids) { ['GB'] }

  login_ls_buyer

  before { allow(Supplier::Framework).to receive(:with_services_and_jurisdiction).with(service_ids, jurisdiction_ids).and_return(supplier_frameworks) }

  describe 'GET index' do
    before { get :index, params: }

    context 'when the lot answer is lot 1' do
      let(:lot_id) { 'RM6360.1' }

      let(:params) do
        {
          journey: 'legal_panel_for_government',
          lot_id: lot_id,
          service_ids: service_ids,
          central_government: central_government,
        }
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'assigns supplier_frameworks available in lot & regions, with services' do
        expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
      end

      it 'assigns lot to the correct lot' do
        expect(assigns(:lot)).to eq(lot)
      end

      it 'sets the back path to the choose-services question' do
        expected_path = journey_question_path(
          journey: 'legal-panel-for-government',
          slug: 'choose-services',
          lot_id: lot_id,
          service_ids: service_ids,
          central_government: central_government
        )
        expect(assigns(:back_path)).to eq(expected_path)
      end

      it 'class with_services_and_jurisdiction' do
        expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, ['GB'])
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3788' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('legal_panel_for_government/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when the lot is RM6360.4a' do
      let(:lot_id) { 'RM6360.4a' }

      context 'and requirements are in a core jurisdiction' do
        let(:not_core_jurisdiction) { 'no' }

        let(:params) do
          {
            journey: 'legal_panel_for_government',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            central_government: central_government,
          }
        end

        it 'renders the index template' do
          expect(response).to render_template('index')
        end

        it 'assigns supplier_frameworks available in lot & regions, with services' do
          expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
        end

        it 'assigns lot to the correct lot' do
          expect(assigns(:lot)).to eq(lot)
        end

        it 'sets the back path to the choose-services question' do
          expected_path = journey_question_path(
            journey: 'legal-panel-for-government',
            slug: 'choose-services',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            central_government: central_government
          )
          expect(assigns(:back_path)).to eq(expected_path)
        end

        it 'class with_services_and_jurisdiction' do
          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, ['GB'])
        end
      end

      context 'and requirements are in a non-core jurisdiction' do
        let(:not_core_jurisdiction) { 'yes' }
        let(:jurisdiction_ids) { ['AE', 'AX'] }

        let(:params) do
          {
            journey: 'legal_panel_for_government',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            jurisdiction_ids: jurisdiction_ids,
            central_government: central_government,
          }
        end

        it 'renders the index template' do
          expect(response).to render_template('index')
        end

        it 'assigns supplier_frameworks available in lot & regions, with services' do
          expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
        end

        it 'assigns lot to the correct lot' do
          expect(assigns(:lot)).to eq(lot)
        end

        it 'sets the back path to the choose-services question' do
          expected_path = journey_question_path(
            journey: 'legal-panel-for-government',
            slug: 'choose-services',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            jurisdiction_ids: jurisdiction_ids,
            central_government: central_government
          )
          expect(assigns(:back_path)).to eq(expected_path)
        end

        it 'class with_services_and_jurisdiction' do
          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, ['AE', 'AX'])
        end
      end
    end
  end

  describe 'GET download' do
    let(:lot_id) { 'RM6360.1' }

    let(:params) do
      {
        journey: 'legal_panel_for_government',
        lot_id: lot_id,
        service_ids: service_ids,
        central_government: central_government,
      }
    end

    context 'and the request format is html' do
      before { get :download, params: }

      it 'renders the download template' do
        expect(response).to render_template('download')
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3788' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('legal_panel_for_government/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'and the request format us xlsx' do
      let(:spreadsheet_builder) { instance_double(LegalPanelForGovernment::RM6360::SupplierSpreadsheetCreator, { build: spreadsheet }) }
      let(:spreadsheet) { instance_double(Axlsx::Package, { to_stream: spreadsheet_stream }) }
      let(:spreadsheet_stream) { instance_double(StringIO, { read: 'spreadsheet-data' }) }

      before do
        allow(LegalPanelForGovernment::RM6360::SupplierSpreadsheetCreator).to receive(:new).and_return(spreadsheet_builder)
        get :download, params: params.merge(format: 'xlsx')
      end

      it 'download a spreadsheet' do
        expect(response.media_type).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

        expect(response.headers['Content-Disposition']).to include 'filename="Shortlist of Legal Panel for Government Suppliers.xlsx"'
      end
    end
  end

  describe 'GET show' do
    before do
      create(:supplier_framework_lot_rate, supplier_framework_lot: create(:supplier_framework_lot, supplier_framework:, lot_id:))

      get :show, params: { id: supplier_framework.id, **params }
    end

    context 'when the lot answer is lot 1' do
      let(:lot_id) { 'RM6360.1' }

      let(:params) do
        {
          journey: 'legal_panel_for_government',
          lot_id: lot_id,
          service_ids: service_ids,
          central_government: central_government,
        }
      end

      it 'renders the show template' do
        expect(response).to render_template('show')
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3788' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('legal_panel_for_government/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
