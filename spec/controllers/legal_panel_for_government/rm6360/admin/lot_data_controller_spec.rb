require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::LotDataController do
  let(:default_params) { { service: 'legal_panel_for_government/admin', framework: 'RM6360', supplier_id: supplier_framework.id } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6360') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6360.#{lot_number}") }
  let(:supplier_framework_lot_services) { (1..5).map { |service_number| "RM6360.#{lot_number}.#{service_number}" }.map { |service_id| create(:supplier_framework_lot_service, supplier_framework_lot:, service_id:) } }
  let(:supplier_framework_lot_rates) { Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) } }
  let(:supplier_framework_lot_rates_non_gb) { Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction_non_gb, position_id: position_id) } }
  let(:supplier_framework_lot_jurisdiction) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'GB') }
  let(:supplier_framework_lot_jurisdiction_non_gb) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'BM') }
  let(:lot_number) { '1' }

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
              enabled: true,
              lot: { name: 'Core Legal Services', number: '1', number_as_slug: '1' },
              sections: %i[services rates]
            },
            {
              enabled: nil,
              lot: { name: 'Major Projects and Complex Advice', number: '2', number_as_slug: '2' },
              sections: %i[services rates]
            },
            {
              enabled: nil,
              lot: { name: 'Finance and High Risk/Innovation', number: '3', number_as_slug: '3' },
              sections: %i[services rates]
            },
            {
              enabled: nil,
              lot: { name: 'Trade and Investment Negotiations', number: '4a', number_as_slug: '4a' },
              sections: %i[services jurisdictions rates]
            },
            {
              enabled: nil,
              lot: { name: 'International Trade Disputes', number: '4b', number_as_slug: '4b' },
              sections: %i[services jurisdictions rates]
            },
            {
              enabled: nil,
              lot: { name: 'International Investment Disputes', number: '4c', number_as_slug: '4c' },
              sections: %i[services jurisdictions rates]
            },
            {
              enabled: nil,
              lot: { name: 'Rail Legal Services', number: '5', number_as_slug: '5' },
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
      supplier_framework_lot_services
      supplier_framework_lot_rates
      supplier_framework_lot_rates_non_gb

      get :show, params: { lot_number:, section: }
    end

    shared_examples 'when testing a section' do
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
        expect(assigns(:lot).id).to eq("RM6360.#{lot_number}")
      end

      it 'assigns supplier_framework_lot' do
        expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
      end
    end

    context 'when the lot number is 1' do
      let(:lot_number) { '1' }

      context 'and the section is services' do
        let(:section) { 'services' }

        include_context 'when testing a section'

        it 'assigns services' do
          assigns(:services).each do |group, services|
            expect(group).to be_nil
            expect(services.length).to eq(48)
          end
        end

        it 'assigns supplier_framework_lot_service_ids' do
          assigned_supplier_framework_lot_service_ids = assigns(:supplier_framework_lot_service_ids)

          expect(assigned_supplier_framework_lot_service_ids.count).to eq(5)
          expect(assigned_supplier_framework_lot_service_ids).to eq(supplier_framework_lot_services.map(&:service_id))
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when considering the templates' do
          render_views

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "shared/admin/lot_data/show/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        include_context 'when testing a section'

        it 'assigns jurisdictions' do
          expect(assigns(:jurisdictions).pluck(:id)).to eq(['GB'])
        end

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(7)
          expect(assigned_supplier_framework_lot_rates.map { |position_id, rates| [position_id, rates['GB'].id] }.sort).to eq(supplier_framework_lot_rates.map { |rate| [rate.position_id, rate.id] }.sort)
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when considering the templates' do
          render_views

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "legal_panel_for_government/rm6360/admin/lot_data/show/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }

        it 'redirects to the index page' do
          expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_data_path)
        end
      end
    end

    context 'when the lot number is 4a' do
      let(:lot_number) { '4a' }

      context 'and the section is services' do
        let(:section) { 'services' }

        include_context 'when testing a section'

        it 'assigns services' do
          assigns(:services).each do |group, services|
            expect(group).to be_nil
            expect(services.length).to eq(10)
          end
        end

        it 'assigns supplier_framework_lot_services' do
          assigned_supplier_framework_lot_service_ids = assigns(:supplier_framework_lot_service_ids)

          expect(assigned_supplier_framework_lot_service_ids.count).to eq(5)
          expect(assigned_supplier_framework_lot_service_ids).to eq(supplier_framework_lot_services.map(&:service_id))
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when considering the templates' do
          render_views

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "shared/admin/lot_data/show/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        include_context 'when testing a section'

        it 'assigns jurisdictions' do
          expect(assigns(:jurisdictions).count).to eq(241)
        end

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(12)
          expect(assigned_supplier_framework_lot_rates.map { |position_id, rates| [position_id, rates['GB'].id] }.sort).to eq(supplier_framework_lot_rates.map { |rate| [rate.position_id, rate.id] }.sort)
          expect(assigned_supplier_framework_lot_rates.map { |position_id, rates| [position_id, rates['BM'].id] }.sort).to eq(supplier_framework_lot_rates_non_gb.map { |rate| [rate.position_id, rate.id] }.sort)
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when considering the templates' do
          render_views

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "legal_panel_for_government/rm6360/admin/lot_data/show/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end

      context 'and the section is jurisdictions' do
        let(:section) { 'jurisdictions' }

        include_context 'when testing a section'

        it 'assigns jurisdictions' do
          expect(assigns(:jurisdictions).count).to eq(240)
        end

        it 'assigns supplier_framework_lot_jurisdiction_ids' do
          expect(assigns(:supplier_framework_lot_jurisdiction_ids).sort).to eq(['BM', 'GB'])
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when considering the templates' do
          render_views

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "legal_panel_for_government/rm6360/admin/lot_data/show/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end
    end
  end

  describe 'GET edit' do
    login_ls_admin

    before do
      supplier_framework_lot_services
      supplier_framework_lot_rates
      supplier_framework_lot_rates_non_gb

      get :edit, params: { lot_number:, section: }
    end

    shared_examples 'when testing a section' do
      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end

      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6360')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      it 'assigns lot' do
        expect(assigns(:lot).id).to eq("RM6360.#{lot_number}")
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

      context 'and the section is services' do
        let(:section) { 'services' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_service_ids' do
          expect(assigns(:supplier_framework_lot_service_ids)).to eq(supplier_framework_lot_services.map(&:service_id))
        end
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }

        it 'redirects to the show page' do
          expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_datum_path(section:))
        end
      end
    end

    context 'when the lot number is 4a' do
      let(:lot_number) { '4a' }

      context 'and the section is lot_status' do
        let(:section) { 'lot_status' }

        include_context 'when testing a section'
      end

      context 'and the section is services' do
        let(:section) { 'services' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_service_ids' do
          expect(assigns(:supplier_framework_lot_service_ids)).to eq(supplier_framework_lot_services.map(&:service_id))
        end
      end
    end
  end

  describe 'GET update' do
    login_ls_admin

    before do
      supplier_framework_lot_services
      supplier_framework_lot_rates
      supplier_framework_lot_rates_non_gb

      get :update, params: { lot_number: lot_number, section: section, supplier_framework_lot: model_params }
    end

    shared_examples 'when testing a section' do
      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6360')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      it 'assigns lot' do
        expect(assigns(:lot).id).to eq("RM6360.#{lot_number}")
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
            expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_data_path)
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

      context 'and the section is services' do
        let(:section) { 'services' }
        let(:service_ids) { [1, 2, 3, 6, 7].map { |service_number| "RM6360.#{lot_number}.#{service_number}" } }
        let(:model_params) { { service_ids: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_service_ids' do
          expect(assigns(:supplier_framework_lot_service_ids)).to eq(supplier_framework_lot_services.map(&:service_id))
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_datum_path(section:))
          end

          it 'updates the details' do
            expect(supplier_framework_lot.reload.services.pluck(:service_id)).to eq(service_ids)
          end
        end

        context 'when it is invalid' do
          let(:model_params) { { service_ids: ['Invalid ID'] } }

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

      context 'when the section is unexpected' do
        let(:section) { :something_else }
        let(:model_params) { { enabled: false } }

        it 'redirects to the show page' do
          expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_datum_path(section:))
        end
      end
    end

    context 'when the lot number is 4a' do
      let(:lot_number) { '4a' }

      context 'and the section is lot_status' do
        let(:section) { 'lot_status' }
        let(:model_params) { { enabled: false } }

        include_context 'when testing a section'

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the index page' do
            expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_data_path)
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

      context 'and the section is services' do
        let(:section) { 'services' }
        let(:service_ids) { [1, 2, 3, 6, 7].map { |service_number| "RM6360.#{lot_number}.#{service_number}" } }
        let(:model_params) { { service_ids: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_service_ids' do
          expect(assigns(:supplier_framework_lot_service_ids)).to eq(supplier_framework_lot_services.map(&:service_id))
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_datum_path(section:))
          end

          it 'updates the details' do
            expect(supplier_framework_lot.reload.services.pluck(:service_id)).to eq(service_ids)
          end
        end

        context 'when it is invalid' do
          let(:model_params) { { service_ids: ['Invalid ID'] } }

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
    end
  end
end
