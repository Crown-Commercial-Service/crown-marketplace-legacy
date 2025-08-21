require 'rails_helper'

RSpec.describe LegalServices::RM6240::SuppliersController do
  let(:default_params) { { service: 'legal_services', framework: framework } }
  let(:framework) { 'RM6240' }
  let(:supplier_framework) { create(:supplier_framework) }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework.id) }
  let(:lot_id) { "RM6240.#{lot_number}#{jurisdiction}" }
  let(:lot) { Lot.find(lot_id) }
  let(:services) { Service.where(lot_id:).sample(5) }
  let(:service_ids) { services.map(&:id) }
  let(:service_numbers) { services.map(&:number) }
  let(:jurisdiction) { 'a' }
  let(:central_government) { 'no' }

  login_ls_buyer

  before do
    allow(Supplier::Framework).to receive(:with_services).with(service_ids).and_return(supplier_frameworks)
    allow(Supplier::Framework).to receive(:with_services).with(['RM6240.3.1'], 'GB').and_return(supplier_frameworks)
    allow(Search).to receive(:log_new_search).and_return(true)
  end

  describe 'GET index' do
    before { get :index, params: }

    context 'when the lot answer is lot1' do
      let(:lot_number) { '1' }

      let(:params) do
        {
          journey: 'legal_services',
          lot_number: lot_number,
          service_numbers: service_numbers,
          jurisdiction: jurisdiction,
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

      it 'sets the back path to the managed-service-provider question' do
        expected_path = journey_question_path(
          journey: 'legal-services',
          slug: 'choose-jurisdiction',
          lot_number: lot_number,
          service_numbers: service_numbers,
          jurisdiction: jurisdiction,
          central_government: central_government
        )
        expect(assigns(:back_path)).to eq(expected_path)
      end

      it 'calls with_services' do
        expect(Supplier::Framework).to have_received(:with_services).with(service_ids)
      end

      it 'logs the search' do
        expect(Search).to have_received(:log_new_search).with(lot.framework, controller.current_user, controller.session.id, { central_government:, lot_number:, service_numbers:, jurisdiction: }.stringify_keys, supplier_frameworks)
      end

      context 'when the lot is RM6240.3' do
        let(:lot_number) { '3' }
        let(:jurisdiction) { nil }

        it 'calls with_services with the correct params' do
          expect(Supplier::Framework).to have_received(:with_services).with(['RM6240.3.1'])
        end
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3788' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('legal_services/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe 'GET download' do
    let(:lot_number) { '1' }

    let(:params) do
      {
        journey: 'legal-services',
        lot_number: lot_number,
        service_numbers: service_numbers,
        jurisdiction: jurisdiction,
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
          expect(response).to render_template('legal_services/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'and the request format us xlsx' do
      let(:spreadsheet_builder) { instance_double(LegalServices::RM6240::SupplierSpreadsheetCreator, { build: spreadsheet }) }
      let(:spreadsheet) { instance_double(Axlsx::Package, { to_stream: spreadsheet_stream }) }
      let(:spreadsheet_stream) { instance_double(StringIO, { read: 'spreadsheet-data' }) }

      before do
        allow(LegalServices::RM6240::SupplierSpreadsheetCreator).to receive(:new).and_return(spreadsheet_builder)
        get :download, params: params.merge(format: 'xlsx')
      end

      it 'download a spreadsheet' do
        expect(response.media_type).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

        expect(response.headers['Content-Disposition']).to include 'filename="Shortlist of WPS Legal Services Suppliers.xlsx"'
      end
    end
  end

  describe 'GET show' do
    before do
      create(:supplier_framework_lot_rate, supplier_framework_lot: create(:supplier_framework_lot, supplier_framework:, lot_id:))

      get :show, params: { id: supplier_framework.id, lot_number: lot_number, jurisdiction: jurisdiction }
    end

    context 'when the lot answer is lot 1' do
      let(:lot_number) { '1' }

      it 'renders the show template' do
        expect(response).to render_template('show')
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3788' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('legal_services/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
