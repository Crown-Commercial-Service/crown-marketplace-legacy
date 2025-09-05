require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::LotDataController do
  let(:default_params) { { service: 'legal_panel_for_government/admin', framework: 'RM6360', supplier_id: supplier_framework.id } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6360') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework:) }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the sign-in' do
        get :index
        expect(response).to redirect_to legal_panel_for_government_rm6360_admin_new_user_session_path
      end
    end

    context 'when logged in as a buyer' do
      login_ls_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/legal-panel-for-government/RM6360/admin/not-permitted'
      end
    end

    context 'when logged in as an admin' do
      login_ls_admin

      before do
        supplier_framework_lot

        get :index
      end

      it 'renders the page' do
        expect(response).to render_template(:index)
      end

      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6360')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      # rubocop:disable RSpec/ExampleLength
      it 'assigns supplier_lot_data' do
        expect(assigns(:supplier_lot_data)).to eq(
          [
            {
              enabled: false,
              lot: { name: 'Core Legal Services', number: '1' },
              sections: %i[services rates]
            },
            {
              enabled: false,
              lot: { name: 'Major Projects and Complex Advice', number: '2' },
              sections: %i[services rates]
            },
            {
              enabled: false,
              lot: { name: 'Finance and High Risk/Innovation', number: '3' },
              sections: %i[services rates]
            },
            {
              enabled: false,
              lot: { name: 'Trade and Investment Negotiations', number: '4a' },
              sections: %i[services rates jurisdictions]
            },
            {
              enabled: false,
              lot: { name: 'International Trade Disputes', number: '4b' },
              sections: %i[services rates jurisdictions]
            },
            {
              enabled: false,
              lot: { name: 'International Investment Disputes', number: '4c' },
              sections: %i[services rates jurisdictions]
            },
            {
              enabled: false,
              lot: { name: 'Rail Legal Services', number: '5' },
              sections: %i[services rates]
            }
          ]
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context 'and the framework dose not exist' do
      login_ls_admin

      it 'renders the unrecognised framework page with the right http status' do
        get :index, params: { framework: 'RM3826' }

        expect(response).to render_template('home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET show' do
    login_ls_admin

    before do
      supplier_framework_lot_service
      supplier_framework_lot_rate
      supplier_framework_lot_rate_non_gb

      get :show, params: { lot_datum_id: lot_number, section: section }
    end

    let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6360.#{lot_number}") }
    let(:supplier_framework_lot_service) { create(:supplier_framework_lot_service, supplier_framework_lot:) }
    let(:supplier_framework_lot_rate) { create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) }
    let(:supplier_framework_lot_rate_non_gb) { create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction_non_gb, position_id: position_id) }
    let(:supplier_framework_lot_jurisdiction) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'GB') }
    let(:supplier_framework_lot_jurisdiction_non_gb) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'BM') }
    let(:position_id) { 51 }

    context 'when the lot number is 1' do
      let(:lot_number) { '1' }

      context 'and the section is services' do
        let(:section) { 'services' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6360')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6360.1')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns services' do
          assigns(:services).each do |group, services|
            expect(group).to be_nil
            expect(services.length).to eq(48)
          end
        end

        it 'assigns supplier_framework_lot_services' do
          assigned_supplier_framework_lot_services = assigns(:supplier_framework_lot_services)

          expect(assigned_supplier_framework_lot_services.count).to eq(1)
          expect(assigned_supplier_framework_lot_services.first).to eq(supplier_framework_lot_service.service_id)
        end
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6360')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6360.1')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns jurisdictions' do
          expect(assigns(:jurisdictions).pluck(:id)).to eq(['GB'])
        end

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(1)
          expect(assigned_supplier_framework_lot_rates.first[1]['GB'].id).to eq(supplier_framework_lot_rate.id)
        end
      end
    end

    context 'when the lot number is 4a' do
      let(:lot_number) { '4a' }

      context 'and the section is services' do
        let(:section) { 'services' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6360')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6360.4a')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns services' do
          assigns(:services).each do |group, services|
            expect(group).to be_nil
            expect(services.length).to eq(10)
          end
        end

        it 'assigns supplier_framework_lot_services' do
          assigned_supplier_framework_lot_services = assigns(:supplier_framework_lot_services)

          expect(assigned_supplier_framework_lot_services.count).to eq(1)
          expect(assigned_supplier_framework_lot_services.first).to eq(supplier_framework_lot_service.service_id)
        end
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6360')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6360.4a')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns jurisdictions' do
          expect(assigns(:jurisdictions).count).to eq(241)
        end

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(1)
          expect(assigned_supplier_framework_lot_rates.first[1]['GB'].id).to eq(supplier_framework_lot_rate.id)
          expect(assigned_supplier_framework_lot_rates.first[1]['BM'].id).to eq(supplier_framework_lot_rate_non_gb.id)
        end
      end

      context 'and the section is jurisdictions' do
        let(:section) { 'jurisdictions' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6360')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6360.4a')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns jurisdictions' do
          expect(assigns(:jurisdictions).count).to eq(240)
        end

        it 'assigns supplier_framework_lot_jurisdictions' do
          expect(assigns(:supplier_framework_lot_jurisdictions)).to eq(['GB', 'BM'])
        end
      end
    end
  end
end
