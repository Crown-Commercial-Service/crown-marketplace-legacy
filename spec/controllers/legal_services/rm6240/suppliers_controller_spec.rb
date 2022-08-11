require 'rails_helper'

RSpec.describe LegalServices::RM6240::SuppliersController, type: :controller do
  let(:default_params) { { service: 'legal_services', framework: framework } }
  let(:framework) { 'RM6240' }
  let(:supplier) { create(:legal_services_rm6240_supplier) }
  let(:suppliers) { LegalServices::RM6240::Supplier.where(id: supplier.id) }
  let(:lot) { LegalServices::RM6240::Lot.find_by(number: lot_number) }
  let(:services) { LegalServices::RM6240::Service.where(lot_number: lot_number).sample(5).map(&:code) }
  let(:jurisdiction) { nil }
  let(:central_government) { 'no' }

  include_context 'and RM3788 has expired'

  login_ls_buyer

  before do
    allow(LegalServices::RM6240::Supplier).to receive(:offering_services_in_jurisdiction)
      .with(lot_number, services, jurisdiction).and_return(suppliers)
  end

  describe 'GET index' do
    before { get :index, params: params }

    context 'when the lot answer is lot1' do
      let(:lot_number) { '1' }

      let(:params) do
        {
          journey: 'legal_services',
          lot: lot_number,
          services: services,
          central_government: central_government,
        }
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'assigns suppliers available in lot & regions, with services' do
        expect(assigns(:suppliers)).to eq(suppliers)
      end

      it 'assigns lot to the correct lot' do
        expect(assigns(:lot)).to eq(lot)
      end

      it 'sets the back path to the managed-service-provider question' do
        expected_path = journey_question_path(
          journey: 'legal-services',
          slug: 'choose-services',
          lot: lot_number,
          services: services,
          central_government: central_government
        )
        expect(assigns(:back_path)).to eq(expected_path)
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
        lot: lot_number,
        services: services,
        central_government: central_government,
      }
    end

    context 'and the request format is html' do
      before { get :download, params: params }

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
      let(:spreadsheet_builder) { instance_double('Spreadsheet builder', { build: spreadsheet }) }
      let(:spreadsheet) { instance_double('Spreadsheet', { to_stream: spreadsheet_stream }) }
      let(:spreadsheet_stream) { instance_double('Spreadsheet stream', { read: 'spreadsheet-data' }) }

      before do
        allow(LegalServices::RM6240::SupplierSpreadsheetCreator).to receive(:new).and_return(spreadsheet_builder)
        get :download, params: params.merge(format: 'xlsx')
      end

      pending 'download a spreadsheet' do
        expect(response.media_type).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

        expect(response.headers['Content-Disposition']).to include 'filename="Shortlist of WPS Legal Services Suppliers.xlsx"'
      end
    end
  end

  describe 'GET show' do
    before { get :show, params: { id: supplier.id, lot: lot } }

    context 'when the lot answer is lot1' do
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

    context 'with no lot number set' do
      let(:lot_number) { '' }

      it 'renders the show template' do
        expect(response).to render_template('show')
      end
    end
  end
end
