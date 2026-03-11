require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::LotDataController do
  let(:default_params) { { service: 'legal_panel_for_government/admin', framework: 'RM6360', supplier_id: supplier_framework.id } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6360') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6360.#{lot_number}") }
  let(:supplier_framework_lot_services) { (1..5).map { |service_number| "RM6360.#{lot_number}.#{service_number}" }.map { |service_id| create(:supplier_framework_lot_service, supplier_framework_lot:, service_id:) } }
  let(:supplier_framework_lot_rates) { Position.where(lot_id: "RM6360.#{lot_number}", mandatory: true).pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) } }
  let(:supplier_framework_lot_rates_non_gb) { Position.where(lot_id: "RM6360.#{lot_number}", mandatory: true).pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction_non_gb, position_id: position_id) } }
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

          expect(assigned_supplier_framework_lot_rates.length).to eq(8)
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

          expect(assigned_supplier_framework_lot_rates.length).to eq(9)
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
    let(:expected_template) { "shared/admin/lot_data/edit/_#{section}" }
    let(:jurisdiction_id) { nil }

    login_ls_admin

    before do
      supplier_framework_lot_services
      supplier_framework_lot_rates
      supplier_framework_lot_rates_non_gb

      method_params = { lot_number:, section: }
      method_params[:jurisdiction_id] = jurisdiction_id if jurisdiction_id

      get :edit, params: method_params
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
          expect(response).to render_template(partial: expected_template)
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

      context 'and the section is rates' do
        let(:section) { 'rates' }
        let(:expected_template) { "legal_panel_for_government/rm6360/admin/lot_data/edit/_#{section}" }

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

      context 'and the section is rates' do
        let(:section) { 'rates' }
        let(:jurisdiction_id) { 'BM' }
        let(:expected_template) { "legal_panel_for_government/rm6360/admin/lot_data/edit/_#{section}" }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(supplier_framework_lot_rates_non_gb.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, supplier_framework_lot_rate.id] } + Position.where(lot_id: "RM6360.#{lot_number}", mandatory: false).pluck(:id).map { |position_id| [position_id, nil] })
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction_non_gb)
        end
      end
    end
  end

  describe 'GET update' do
    let(:jurisdiction_id) { nil }

    login_ls_admin

    before do
      supplier_framework_lot_services
      supplier_framework_lot_rates
      supplier_framework_lot_rates_non_gb

      method_params = { lot_number: lot_number, section: section, supplier_framework_lot: model_params }
      method_params[:jurisdiction_id] = jurisdiction_id if jurisdiction_id

      get :update, params: method_params
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
          let(:service_ids) { ['Invalid ID'] }

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
        let(:rates) { Position.where(lot_id: "RM6360.#{lot_number}", mandatory: true).pluck(:id).index_with { '2345.67' } }
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
            expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_datum_path(section:))
          end

          it 'updates the details' do
            updated_supplier_framework_lot_rates = supplier_framework_lot.rates.where(position_id: Position.where(lot_id: "RM6360.#{lot_number}", mandatory: true).select(:id), supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction.id)

            expect(updated_supplier_framework_lot_rates.length).to eq(8)

            updated_supplier_framework_lot_rates.each do |rate|
              expect(rate.rate).to eq(234567)
            end
          end
        end

        context 'when it is invalid' do
          let(:rates) { Position.where(lot_id: "RM6360.#{lot_number}", mandatory: true).pluck(:id).index_with { '' } }

          render_views

          it 'has errors on the model' do
            assigns(:supplier_framework_lot_rates).each_value do |supplier_framework_lot_rate|
              expect(supplier_framework_lot_rate.errors).to be_present
            end
          end

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "legal_panel_for_government/rm6360/admin/lot_data/edit/_#{section}")
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

      context 'and the section is rates' do
        let(:section) { 'rates' }
        let(:jurisdiction_id) { 'BM' }
        let(:supplier_framework_lot_rates_non_gb) { (1..11).map { |position_number| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction_non_gb, position_id: "RM6360.4a.#{position_number}") } }
        let(:rates) do
          {
            'RM6360.4a.1': '1234.56',
            'RM6360.4a.2': '1234.56',
            'RM6360.4a.3': '1234.56',
            'RM6360.4a.4': '1234.56',
            'RM6360.4a.5': '1234.56',
            'RM6360.4a.6': '1234.56',
            'RM6360.4a.7': '1234.56',
            'RM6360.4a.8': '1234.56',
            'RM6360.4a.9': '1234.56',
            'RM6360.4a.10': '',
            'RM6360.4a.11': '1234.56',
            'RM6360.4a.12': '1234.56',
            'RM6360.4a.13': '',
          }
        end
        let(:model_params) { { rates: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id.nil?] }).to eq(supplier_framework_lot_rates_non_gb.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, false] } + [['RM6360.4a.12', false], ['RM6360.4a.13', true]])
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction_non_gb)
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_supplier_lot_datum_path(section:))
          end

          # rubocop:disable RSpec/ExampleLength
          it 'updates the details' do
            updated_supplier_framework_lot_rates = supplier_framework_lot.rates.where(supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction_non_gb.id).to_h { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, supplier_framework_lot_rate.rate] }

            expected_rates = {
              'RM6360.4a.1' => 123456,
              'RM6360.4a.2' => 123456,
              'RM6360.4a.3' => 123456,
              'RM6360.4a.4' => 123456,
              'RM6360.4a.5' => 123456,
              'RM6360.4a.6' => 123456,
              'RM6360.4a.7' => 123456,
              'RM6360.4a.8' => 123456,
              'RM6360.4a.9' => 123456,
              'RM6360.4a.10' => nil,
              'RM6360.4a.11' => 123456,
              'RM6360.4a.12' => 123456,
              'RM6360.4a.13' => nil,
            }

            expect(updated_supplier_framework_lot_rates.length).to eq(11)

            expected_rates.each do |position_id, expected_rate|
              expect(updated_supplier_framework_lot_rates[position_id]).to eq(expected_rate)
            end
          end
          # rubocop:enable RSpec/ExampleLength
        end

        context 'when it is invalid' do
          let(:rates) do
            {
              'RM6360.4a.1': '',
              'RM6360.4a.2': '',
              'RM6360.4a.3': '',
              'RM6360.4a.4': '',
              'RM6360.4a.5': '',
              'RM6360.4a.6': '',
              'RM6360.4a.7': '',
              'RM6360.4a.8': '',
              'RM6360.4a.9': '',
              'RM6360.4a.10': '',
              'RM6360.4a.11': '',
              'RM6360.4a.12': '',
              'RM6360.4a.13': '',
            }
          end

          render_views

          it 'has errors on the model' do
            assigns(:supplier_framework_lot_rates).each_value do |supplier_framework_lot_rate|
              if ['RM6360.4a.10', 'RM6360.4a.11', 'RM6360.4a.12', 'RM6360.4a.13'].include?(supplier_framework_lot_rate.position_id)
                expect(supplier_framework_lot_rate.errors).to be_none
              else
                expect(supplier_framework_lot_rate.errors).to be_present
              end
            end
          end

          it 'renders section partial template' do
            expect(response).to have_http_status(:ok)
            expect(response).to render_template(partial: "legal_panel_for_government/rm6360/admin/lot_data/edit/_#{section}")
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end
    end
  end
end
