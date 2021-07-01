require 'rails_helper'

RSpec.describe ManagementConsultancy::SuppliersController, type: :controller do
  let(:default_params) { { service: 'management_consultancy' } }
  let(:supplier) { create(:management_consultancy_supplier) }
  let(:suppliers) { ManagementConsultancy::Supplier.where(id: supplier.id) }
  let(:lot) { ManagementConsultancy::Lot.find_by(number: lot_number) }
  let(:services) { ManagementConsultancy::Service.all.sample(5).map(&:code) }
  let(:region_codes) { Nuts2Region.all.sample(5).map(&:code) }

  login_mc_buyer

  before do
    allow(Marketplace).to receive(:mcf3_live?).and_return(mcf3_live)
    allow(ManagementConsultancy::Supplier).to receive(:offering_services_in_regions)
      .with(lot_number, services, region_codes).and_return(suppliers)
    allow(ManagementConsultancy::Supplier).to receive(:offering_services)
      .with(lot_number, services).and_return(suppliers)
  end

  describe 'GET index' do
    before { get :index, params: params }

    context 'when mcf3_live is not live' do
      let(:mcf3_live) { false }

      let(:params) do
        {
          journey: 'management-consultancy',
          lot: lot_number,
          services: services,
          region_codes: region_codes,
        }
      end

      context 'when the lot answer is MCF2 lot 1' do
        let(:lot_number) { 'MCF2.1' }

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
            journey: 'management-consultancy',
            slug: 'choose-regions',
            lot: lot_number,
            services: services,
            region_codes: region_codes
          )
          expect(assigns(:back_path)).to eq(expected_path)
        end
      end

      context 'when the lot answer is MCF2 lot 2' do
        let(:lot_number) { 'MCF2.2' }

        it 'assigns lot to the correct lot' do
          expect(assigns(:lot)).to eq(lot)
        end

        it 'renders the index template' do
          expect(response).to render_template('index')
        end

        it 'assigns suppliers available in lot & regions, with services' do
          expect(assigns(:suppliers)).to eq(suppliers)
        end
      end

      context 'and the lot number is for MCF3' do
        let(:lot_number) { 'MCF3.5' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_path
        end
      end
    end

    context 'when mcf3_live is live' do
      let(:mcf3_live) { true }

      let(:params) do
        {
          journey: 'management-consultancy',
          lot: lot_number,
          services: services,
          region_codes: region_codes,
        }
      end

      context 'when the lot answer is MCF3 lot 4' do
        let(:lot_number) { 'MCF3.4' }

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
            journey: 'management-consultancy',
            slug: 'choose-services',
            lot: lot_number,
            services: services
          )
          expect(assigns(:back_path)).to eq(expected_path)
        end
      end

      context 'and the lot number is for MCF1' do
        let(:lot_number) { 'MCF1.5' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_path
        end
      end
    end
  end

  describe 'GET download' do
    before { get :download, params: params }

    context 'when mcf3_live is not live' do
      let(:mcf3_live) { false }

      let(:lot_number) { 'MCF2.2' }

      let(:params) do
        {
          journey: 'management-consultancy',
          lot: lot_number,
          services: services,
          region_codes: region_codes,
        }
      end

      it 'renders the download template' do
        expect(response).to render_template('download')
      end

      context 'and the lot number is for MCF3' do
        let(:lot_number) { 'MCF3.2' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_path
        end
      end
    end

    context 'when mcf3_live is live' do
      let(:mcf3_live) { true }

      let(:lot_number) { 'MCF3.4' }

      let(:params) do
        {
          journey: 'management-consultancy',
          lot: lot_number,
          services: services
        }
      end

      it 'renders the download template' do
        expect(response).to render_template('download')
      end

      context 'and the lot number is for MCF' do
        let(:lot_number) { 'MCF1.2' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_path
        end
      end
    end
  end

  describe 'GET show' do
    before { get :show, params: { id: supplier.id, lot: lot_number } }

    context 'when mcf3_live is not live' do
      let(:mcf3_live) { false }

      context 'when the lot answer is MCF2 lot 1' do
        let(:lot_number) { 'MCF2.1' }

        it 'renders the show template' do
          expect(response).to render_template('show')
        end
      end

      context 'and the lot number is for MCF3' do
        let(:lot_number) { 'MCF3.1' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_path
        end
      end
    end

    context 'when mcf3_live is live' do
      let(:mcf3_live) { true }

      context 'when the lot answer is MCF3 lot 8' do
        let(:lot_number) { 'MCF3.8' }

        it 'renders the show template' do
          expect(response).to render_template('show')
        end
      end

      context 'and the lot number is for MCF2' do
        let(:lot_number) { 'MCF2.2' }

        it 'redirects back to the start' do
          expect(response).to redirect_to management_consultancy_path
        end
      end
    end
  end
end
