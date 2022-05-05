require 'rails_helper'

RSpec.describe LegalServices::RM3788::SuppliersController, type: :controller do
  let(:default_params) { { service: 'legal_services', framework: framework } }
  let(:framework) { 'RM3788' }
  let(:supplier) { create(:legal_services_rm3788_supplier) }
  let(:suppliers) { LegalServices::RM3788::Supplier.where(id: supplier.id) }
  let(:lot) { LegalServices::RM3788::Lot.find_by(number: lot_number) }
  let(:services) { LegalServices::RM3788::Service.where(lot_number: lot_number).sample(5).map(&:code) }
  let(:jurisdiction) { nil }
  let(:central_government) { 'no' }
  let(:region_codes) { Nuts1Region.all.sample(5).map(&:code) }

  include_context 'and RM6240 is live in the future'

  login_ls_buyer

  before do
    allow(LegalServices::RM3788::Supplier).to receive(:offering_services_in_regions)
      .with(lot_number, services, jurisdiction, region_codes).and_return(suppliers)
  end

  describe 'GET index' do
    before do
      get :index, params: params
    end

    context 'when the lot answer is lot1' do
      let(:lot_number) { '1' }

      let(:params) do
        {
          journey: 'legal_services',
          lot: lot_number,
          services: services,
          region_codes: region_codes,
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
          slug: 'choose-regions',
          lot: lot_number,
          services: services,
          region_codes: region_codes,
          central_government: central_government
        )
        expect(assigns(:back_path)).to eq(expected_path)
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6240' }

        it 'redirects to the framework path' do
          expect(response).to redirect_to legal_services_path
        end
      end
    end
  end

  describe 'GET download' do
    before do
      get :download, params: params
    end

    let(:lot_number) { '1' }

    let(:params) do
      {
        journey: 'legal-services',
        lot: lot_number,
        services: services,
        region_codes: region_codes,
        central_government: central_government,
      }
    end

    it 'renders the download template' do
      expect(response).to render_template('download')
    end

    context 'when the framework is not the current framework' do
      let(:framework) { 'RM6240' }

      it 'redirects to the framework path' do
        expect(response).to redirect_to legal_services_path
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: supplier.id, lot: lot }
    end

    context 'when the lot answer is lot1' do
      let(:lot_number) { '1' }

      it 'renders the show template' do
        expect(response).to render_template('show')
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6240' }

        it 'redirects to the framework path' do
          expect(response).to redirect_to legal_services_path
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
