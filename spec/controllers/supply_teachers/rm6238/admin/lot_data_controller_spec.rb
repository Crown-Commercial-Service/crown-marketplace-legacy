require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Admin::LotDataController do
  let(:default_params) { { service: 'supply_teachers/admin', framework: 'RM6238', supplier_id: supplier_framework.id } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6238') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6238.#{lot_number}") }
  let(:supplier_framework_lot_rates) { Position.where(lot_id: "RM6238.#{lot_number}").pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) } }
  let(:supplier_framework_lot_jurisdiction) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'GB') }
  let(:supplier_framework_lot_branch) { create(:supplier_framework_lot_branch, supplier_framework_lot:) }
  let(:lot_number) { '1' }

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
              lot: { number: '1', name: 'Direct provision', number_as_slug: '1' },
              enabled: true,
              sections: %i[rates branches]
            },
            {
              lot: { number: '2.1', name: 'Master vendor (less than 2.5 million)', number_as_slug: '2-1' },
              enabled: nil,
              sections: %i[rates]
            },
            {
              lot: { number: '2.2', name: 'Master vendor (more than 2.5 million)', number_as_slug: '2-2' },
              enabled: nil,
              sections: %i[rates]
            },
            {
              lot: { number: '4', name: 'Education technology platforms', number_as_slug: '4' },
              enabled: nil,
              sections: %i[rates]
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
      supplier_framework_lot_rates
      supplier_framework_lot_branch

      get :show, params: { lot_number:, section: }
    end

    shared_examples 'when testing a section' do
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
        expect(assigns(:lot).id).to eq("RM6238.#{lot_number}")
      end

      it 'assigns supplier_framework_lot' do
        expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
      end

      context 'when considering the templates' do
        render_views

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "supply_teachers/rm6238/admin/lot_data/show/_#{section}")
        end
      end
    end

    context 'when the lot number is 1' do
      let(:lot_number) { '1' }

      context 'and the section is rates' do
        let(:section) { 'rates' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(11)
          expect(assigned_supplier_framework_lot_rates.map { |position_id, rate| [position_id, rate.id] }.sort).to eq(supplier_framework_lot_rates.map { |rate| [rate.position_id, rate.id] }.sort)
        end
      end

      context 'and the section is branches' do
        let(:section) { 'branches' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_branches' do
          assigned_supplier_framework_lot_branches = assigns(:supplier_framework_lot_branches)

          expect(assigned_supplier_framework_lot_branches.count).to eq(1)
          expect(assigned_supplier_framework_lot_branches.first.id).to eq(supplier_framework_lot_branch.id)
        end
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }

        it 'redirects to the index page' do
          expect(response).to redirect_to(supply_teachers_rm6238_admin_supplier_lot_data_path)
        end
      end
    end
  end

  describe 'GET edit' do
    login_st_admin

    before do
      supplier_framework_lot_rates
      supplier_framework_lot_branch

      get :edit, params: { lot_number:, section: }
    end

    shared_examples 'when testing a section' do
      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end

      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6238')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      it 'assigns lot' do
        expect(assigns(:lot).id).to eq("RM6238.#{lot_number}")
      end

      it 'assigns supplier_framework_lot' do
        expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
      end

      it 'assigns model' do
        expect(assigns(:model).class).to be(Supplier::Framework::Lot)
      end

      context 'when considering the templates' do
        render_views

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "shared/admin/lot_data/edit/_#{section}")
        end
      end
    end

    context 'when the lot number is 1' do
      let(:lot_number) { '1' }

      context 'and the section is lot_status' do
        let(:section) { 'lot_status' }

        include_context 'when testing a section'
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(supplier_framework_lot_rates.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, supplier_framework_lot_rate.id] })
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction)
        end
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }

        it 'redirects to the show page' do
          expect(response).to redirect_to(supply_teachers_rm6238_admin_supplier_lot_datum_path(section:))
        end
      end
    end
  end

  describe 'GET update' do
    login_st_admin

    before do
      supplier_framework_lot_rates
      supplier_framework_lot_branch

      get :update, params: { lot_number: lot_number, section: section, supplier_framework_lot: model_params }
    end

    shared_examples 'when testing a section' do
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

      it 'assigns model' do
        expect(assigns(:model).class).to be(Supplier::Framework::Lot)
      end
    end

    context 'when the lot number is 1' do
      let(:lot_number) { '1' }

      context 'and the section is lot_status' do
        let(:section) { 'lot_status' }
        let(:model_params) { { enabled: 'false' } }

        include_context 'when testing a section'

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the index page' do
            expect(response).to redirect_to(supply_teachers_rm6238_admin_supplier_lot_data_path)
          end

          it 'updates the details' do
            expect(supplier_framework_lot.reload.enabled).to be(false)
          end
        end

        context 'when it is invalid' do
          let(:model_params) { { enabled: nil } }

          render_views

          it 'has errors on the model' do
            expect(assigns(:model).errors).to be_present
          end

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "shared/admin/lot_data/edit/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }
        # rubocop:disable Style/HashTransformValues
        let(:rates) { Position.where(lot_id: "RM6238.#{lot_number}").pluck(:id, :rate_type).to_h { |position_id, rate_type| [position_id, rate_type == 'percentage' ? '44.5' : '2345.67'] } }
        # rubocop:enable Style/HashTransformValues
        let(:model_params) { { rates: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(supplier_framework_lot_rates.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, supplier_framework_lot_rate.id] })
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction)
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(supply_teachers_rm6238_admin_supplier_lot_datum_path(section:))
          end

          it 'updates the details' do
            updated_supplier_framework_lot_rates = supplier_framework_lot.rates.where(position_id: Position.where(lot_id: "RM6238.#{lot_number}").select(:id), supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction.id)

            expect(updated_supplier_framework_lot_rates.length).to eq(11)

            updated_supplier_framework_lot_rates.each do |rate|
              expect(rate.rate).to eq(rate.rate_type == 'percentage' ? 4450 : 234567)
            end
          end
        end

        context 'when it is invalid' do
          let(:rates) { Position.where(lot_id: "RM6238.#{lot_number}").pluck(:id).index_with { '' } }

          render_views

          it 'has errors on the model' do
            assigns(:supplier_framework_lot_rates).each_value do |supplier_framework_lot_rate|
              expect(supplier_framework_lot_rate.errors).to be_present
            end
          end

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "shared/admin/lot_data/edit/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }
        let(:model_params) { { enabled: 'false' } }

        it 'redirects to the show page' do
          expect(response).to redirect_to(supply_teachers_rm6238_admin_supplier_lot_datum_path(section:))
        end
      end
    end
  end
end
