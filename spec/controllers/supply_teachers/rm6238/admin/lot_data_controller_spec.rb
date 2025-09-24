require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Admin::LotDataController do
  let(:default_params) { { service: 'supply_teachers/admin', framework: 'RM6238', supplier_id: supplier_framework.id } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6238') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework:) }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the sign-in' do
        get :index
        expect(response).to redirect_to supply_teachers_rm6238_admin_new_user_session_path
      end
    end

    context 'when logged in as a buyer' do
      login_st_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/supply-teachers/RM6238/admin/not-permitted'
      end
    end

    context 'when logged in as an admin' do
      login_st_admin

      before do
        supplier_framework_lot

        get :index
      end

      it 'renders the page' do
        expect(response).to render_template(:index)
      end

      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6238')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      # rubocop:disable RSpec/ExampleLength
      it 'assigns supplier_lot_data' do
        expect(assigns(:supplier_lot_data)).to eq(
          [
            {
              lot: { number: '1', name: 'Direct provision' },
              enabled: false,
              sections: %i[rates branches]
            },
            {
              lot: { number: '2.1', name: 'Master vendor (less than 2.5 million)' },
              enabled: false,
              sections: [:rates]
            },
            {
              lot: { number: '2.2', name: 'Master vendor (more than 2.5 million)' },
              enabled: false,
              sections: [:rates]
            },
            {
              lot: { number: '4', name: 'Education technology platforms' },
              enabled: false,
              sections: [:rates]
            },
          ]
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context 'and the framework dose not exist' do
      login_st_buyer

      it 'renders the unrecognised framework page with the right http status' do
        get :index, params: { framework: 'RM3826' }

        expect(response).to render_template('home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET show' do
    login_st_admin

    before do
      supplier_framework_lot_rate
      supplier_framework_lot_branch

      get :show, params: { lot_datum_id: lot_number, section: section }
    end

    let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6238.#{lot_number}") }
    let(:supplier_framework_lot_rate) { create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) }
    let(:supplier_framework_lot_jurisdiction) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'GB') }
    let(:supplier_framework_lot_branch) { create(:supplier_framework_lot_branch, supplier_framework_lot:) }
    let(:position_id) { "RM6238.#{lot_number}.1" }

    context 'when the lot number is 1' do
      let(:lot_number) { '1' }

      context 'and the section is rates' do
        let(:section) { 'rates' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6238')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6238.1')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(1)
          expect(assigned_supplier_framework_lot_rates[position_id].id).to eq(supplier_framework_lot_rate.id)
        end
      end

      context 'and the section is branches' do
        let(:section) { 'branches' }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'assigns framework' do
          expect(assigns(:framework).id).to eq('RM6238')
        end

        it 'assigns supplier_framework' do
          expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
        end

        it 'assigns lot' do
          expect(assigns(:lot).id).to eq('RM6238.1')
        end

        it 'assigns supplier_framework_lot' do
          expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
        end

        it 'assigns supplier_framework_lot_branches' do
          assigned_supplier_framework_lot_branches = assigns(:supplier_framework_lot_branches)

          expect(assigned_supplier_framework_lot_branches.count).to eq(1)
          expect(assigned_supplier_framework_lot_branches.first.id).to eq(supplier_framework_lot_branch.id)
        end
      end
    end
  end
end
