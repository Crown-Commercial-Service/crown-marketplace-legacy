require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::SuppliersController do
  let(:default_params) { { service: 'management_consultancy', framework: framework } }
  let(:framework) { 'RM6187' }
  let(:supplier_framework) { create(:supplier_framework) }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework.id) }
  let(:lot) { Lot.find(lot_id) }
  let(:service_ids) { Service.where(lot_id:).sample(5).map(&:id) }

  login_mc_buyer

  before do
    allow(Supplier::Framework).to receive(:with_services).with(service_ids).and_return(supplier_frameworks)
  end

  include_context 'and RM6187 is live'

  describe 'GET index' do
    before { get :index, params: }

    let(:params) do
      {
        journey: 'management-consultancy',
        lot_id: lot_id,
        service_ids: service_ids,
      }
    end

    context 'when the lot answer is MCF3 lot 4' do
      let(:lot_id) { 'RM6187.4' }

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
          lot_id: lot_id,
          service_ids: service_ids
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
  end

  describe 'GET download' do
    let(:lot_id) { 'RM6187.4' }

    let(:params) do
      {
        journey: 'management-consultancy',
        lot_id: lot_id,
        service_ids: service_ids
      }
    end

    context 'when the format is html' do
      before { get :download, params: params, format: :html }

      it 'renders the download template' do
        expect(response).to render_template('download')
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
    before do
      create(:supplier_framework_lot_rate, supplier_framework_lot: create(:supplier_framework_lot, supplier_framework:, lot_id:))

      get :show, params: { id: supplier_framework.id, lot_id: lot_id }
    end

    context 'when the lot answer is MCF3 lot 8' do
      let(:lot_id) { 'RM6187.8' }

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
  end
end
