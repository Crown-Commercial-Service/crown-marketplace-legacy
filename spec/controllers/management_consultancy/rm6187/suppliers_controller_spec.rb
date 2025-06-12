require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::SuppliersController do
  let(:default_params) { { service: 'management_consultancy', framework: framework } }
  let(:framework) { 'RM6187' }
  let(:supplier) { create(:management_consultancy_rm6187_supplier) }
  let(:suppliers) { ManagementConsultancy::RM6187::Supplier.where(id: supplier.id) }
  let(:lot) { ManagementConsultancy::RM6187::Lot.find_by(number: lot_number) }
  let(:services) { ManagementConsultancy::RM6187::Service.all.sample(5).map(&:code) }

  login_mc_buyer

  before do
    allow(ManagementConsultancy::RM6187::Supplier).to receive(:offering_services)
      .with(lot_number, services).and_return(suppliers)
  end

  include_context 'and RM6187 is live'

  describe 'GET index' do
    before { get :index, params: }

    let(:params) do
      {
        journey: 'management-consultancy',
        lot: lot_number,
        services: services,
      }
    end

    context 'when the lot answer is MCF3 lot 4' do
      let(:lot_number) { 'MCF3.4' }

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'assigns lot to the correct lot' do
        expect(assigns(:lot)).to eq(lot)
      end

      it 'sets the back path to the managed-service-provider question' do
        expected_path = journey_question_path(
          journey: 'management-consultancy',
          slug: 'choose-services',
          lot: lot_number,
          services: services
        )
        expect(assigns(:back_path)).to eq(expected_path)
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6232' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('management_consultancy/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'and the lot number is for MCF1' do
      let(:lot_number) { 'MCF1.5' }

      it 'redirects back to the start' do
        expect(response).to redirect_to management_consultancy_rm6187_path
      end
    end
  end

  describe 'GET download' do
    let(:lot_number) { 'MCF3.4' }

    let(:params) do
      {
        journey: 'management-consultancy',
        lot: lot_number,
        services: services
      }
    end

    context 'when the format is html' do
      before { get :download, params: params, format: :html }

      it 'renders the download template' do
        expect(response).to render_template('download')
      end

      context 'and the lot number is for MCF' do
        let(:lot_number) { 'MCF1.2' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_rm6187_path
        end
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6232' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('management_consultancy/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when the format is xlsx' do
      before do
        spreadsheet_builder_double = double
        spreadsheet_double = double
        spreadsheet_streem_double = double

        allow(ManagementConsultancy::RM6187::SupplierSpreadsheetCreator).to receive(:new).and_return(spreadsheet_builder_double)
        allow(spreadsheet_builder_double).to receive(:build).and_return(spreadsheet_double)
        allow(spreadsheet_double).to receive(:to_stream).and_return(spreadsheet_streem_double)
        allow(spreadsheet_streem_double).to receive(:read)
        get :download, params: params, format: :xlsx
      end

      it 'downloads the document with the right filename and file type' do
        expect(response.headers['Content-Disposition']).to include 'filename="shortlist_of_management_consultancy_suppliers'
        expect(response.headers['Content-Type']).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6232' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('management_consultancy/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe 'GET show' do
    before { get :show, params: { id: supplier.id, lot: lot_number } }

    context 'when the lot answer is MCF3 lot 8' do
      let(:lot_number) { 'MCF3.8' }

      it 'renders the show template' do
        expect(response).to render_template('show')
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6232' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('management_consultancy/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'and the lot number is for MCF2' do
      let(:lot_number) { 'MCF2.2' }

      it 'redirects back to the start' do
        expect(response).to redirect_to management_consultancy_rm6187_path
      end
    end
  end
end
