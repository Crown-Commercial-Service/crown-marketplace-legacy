require 'rails_helper'

RSpec.describe LegalServices::RM6240::Admin::LotDataController do
  let(:default_params) { { service: 'legal_services/admin', framework: 'RM6240', supplier_id: supplier_framework.id } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6240') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6240.#{lot_number}") }
  let(:supplier_framework_lot_services) { (lot_number == '3' ? [1] : (1..5)).map { |service_number| "RM6240.#{lot_number}.#{service_number}" }.map { |service_id| create(:supplier_framework_lot_service, supplier_framework_lot:, service_id:) } }
  let(:supplier_framework_lot_rates) { Position.where(lot_id: "RM6240.#{lot_number}", mandatory: true).pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) } }
  let(:supplier_framework_lot_jurisdiction) { create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'GB') }
  let(:lot_number) { '1a' }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the sign-in' do
        get :index
        expect(response).to redirect_to legal_services_rm6240_admin_new_user_session_path
      end
    end

    context 'when logged in as a buyer' do
      login_ls_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/legal-services/RM6240/admin/not-permitted'
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
        expect(assigns(:framework).id).to eq('RM6240')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      # rubocop:disable RSpec/ExampleLength
      it 'assigns supplier_lot_data' do
        expect(assigns(:supplier_lot_data)).to eq(
          [
            {
              lot: { number: '1a', name: 'Full service provision', number_as_slug: '1a' },
              enabled: true,
              sections: %i[services rates]
            },
            {
              lot: { number: '1b', name: 'Full service provision', number_as_slug: '1b' },
              enabled: nil,
              sections: %i[services rates]
            },
            {
              lot: { number: '1c', name: 'Full service provision', number_as_slug: '1c' },
              enabled: nil,
              sections: %i[services rates]
            },
            {
              lot: { number: '2a', name: 'General service provision', number_as_slug: '2a' },
              enabled: nil,
              sections: %i[services rates]
            },
            {
              lot: { number: '2b', name: 'General service provision', number_as_slug: '2b' },
              enabled: nil,
              sections: %i[services rates]
            },
            {
              lot: { number: '2c', name: 'General service provision', number_as_slug: '2c' },
              enabled: nil,
              sections: %i[services rates]
            },
            {
              lot: { number: '3', name: 'Transport rail legal services', number_as_slug: '3' },
              enabled: nil,
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

      get :show, params: { lot_number:, section: }
    end

    shared_examples 'when testing a section' do
      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6240')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      it 'assigns lot' do
        expect(assigns(:lot).id).to eq("RM6240.#{lot_number}")
      end

      it 'assigns supplier_framework_lot' do
        expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
      end

      context 'when considering the templates' do
        render_views

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "shared/admin/lot_data/show/_#{section}")
        end
      end
    end

    context 'when the lot number is 1a' do
      let(:lot_number) { '1a' }

      context 'and the section is services' do
        let(:section) { 'services' }

        include_context 'when testing a section'

        it 'assigns services' do
          assigns(:services).each do |group, services|
            expect(group).to be_nil
            expect(services.length).to eq(40)
          end
        end

        it 'assigns supplier_framework_lot_service_ids' do
          assigned_supplier_framework_lot_service_ids = assigns(:supplier_framework_lot_service_ids)

          expect(assigned_supplier_framework_lot_service_ids.count).to eq(5)
          expect(assigned_supplier_framework_lot_service_ids).to eq(supplier_framework_lot_services.map(&:service_id))
        end
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(6)
          expect(assigned_supplier_framework_lot_rates.map { |position_id, rate| [position_id, rate.id] }.sort).to eq(supplier_framework_lot_rates.map { |rate| [rate.position_id, rate.id] }.sort)
        end
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }

        it 'redirects to the index page' do
          expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_data_path)
        end
      end
    end

    context 'when the lot number is 3' do
      let(:lot_number) { '3' }

      context 'and the section is services' do
        let(:section) { 'services' }

        include_context 'when testing a section'

        it 'assigns services' do
          assigns(:services).each do |group, services|
            expect(group).to be_nil
            expect(services.length).to eq(1)
          end
        end

        it 'assigns supplier_framework_lot_service_ids' do
          assigned_supplier_framework_lot_service_ids = assigns(:supplier_framework_lot_service_ids)

          expect(assigned_supplier_framework_lot_service_ids.count).to eq(1)
          expect(assigned_supplier_framework_lot_service_ids).to eq(supplier_framework_lot_services.map(&:service_id))
        end
      end

      context 'and the section is rates' do
        let(:section) { 'rates' }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          assigned_supplier_framework_lot_rates = assigns(:supplier_framework_lot_rates)

          expect(assigned_supplier_framework_lot_rates.length).to eq(6)
          expect(assigned_supplier_framework_lot_rates.map { |position_id, rate| [position_id, rate.id] }.sort).to eq(supplier_framework_lot_rates.map { |rate| [rate.position_id, rate.id] }.sort)
        end
      end
    end
  end

  describe 'GET edit' do
    login_ls_admin

    before do
      supplier_framework_lot_services
      supplier_framework_lot_rates

      get :edit, params: { lot_number:, section: }
    end

    shared_examples 'when testing a section' do
      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end

      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6240')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      it 'assigns lot' do
        expect(assigns(:lot).id).to eq("RM6240.#{lot_number}")
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

    context 'when the lot number is 1a' do
      let(:lot_number) { '1a' }

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

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(supplier_framework_lot_rates.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, supplier_framework_lot_rate.id] } + Position.where(lot_id: "RM6240.#{lot_number}", mandatory: false).pluck(:id).map { |position_id| [position_id, nil] })
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction)
        end
      end

      context 'when the section is unexpected' do
        let(:section) { :something_else }

        it 'redirects to the show page' do
          expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_datum_path(section:))
        end
      end
    end

    context 'when the lot number is 3' do
      let(:lot_number) { '3' }

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

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(supplier_framework_lot_rates.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, supplier_framework_lot_rate.id] } + Position.where(lot_id: "RM6240.#{lot_number}", mandatory: false).pluck(:id).map { |position_id| [position_id, nil] })
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction)
        end
      end
    end
  end

  describe 'GET update' do
    login_ls_admin

    before do
      supplier_framework_lot_services
      supplier_framework_lot_rates

      get :update, params: { lot_number: lot_number, section: section, supplier_framework_lot: model_params }
    end

    shared_examples 'when testing a section' do
      it 'assigns framework' do
        expect(assigns(:framework).id).to eq('RM6240')
      end

      it 'assigns supplier_framework' do
        expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
      end

      it 'assigns lot' do
        expect(assigns(:lot).id).to eq("RM6240.#{lot_number}")
      end

      it 'assigns supplier_framework_lot' do
        expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
      end

      it 'assigns model' do
        expect(assigns(:model).class).to be(Supplier::Framework::Lot)
      end
    end

    context 'when the lot number is 1a' do
      let(:lot_number) { '1a' }

      context 'and the section is lot_status' do
        let(:section) { 'lot_status' }
        let(:model_params) { { enabled: 'false' } }

        include_context 'when testing a section'

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the index page' do
            expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_data_path)
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
        let(:service_ids) { [1, 2, 3, 6, 7].map { |service_number| "RM6240.#{lot_number}.#{service_number}" } }
        let(:model_params) { { service_ids: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_service_ids' do
          expect(assigns(:supplier_framework_lot_service_ids)).to eq(supplier_framework_lot_services.map(&:service_id))
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_datum_path(section:))
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
        let(:rates) { Position.where(lot_id: "RM6240.#{lot_number}").pluck(:id).index_with { '2345.67' } }
        let(:model_params) { { rates: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id.nil?] }).to eq(supplier_framework_lot_rates.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, false] } + [["RM6240.#{lot_number}.7", false]])
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction)
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_datum_path(section:))
          end

          it 'updates the details' do
            updated_supplier_framework_lot_rates = supplier_framework_lot.rates.where(position_id: Position.where(lot_id: "RM6240.#{lot_number}").select(:id), supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction.id)

            expect(updated_supplier_framework_lot_rates.length).to eq(7)

            updated_supplier_framework_lot_rates.each do |rate|
              expect(rate.rate).to eq(234567)
            end
          end
        end

        context 'when it is invalid' do
          let(:rates) { Position.where(lot_id: "RM6240.#{lot_number}").pluck(:id).index_with { '' } }

          render_views

          it 'has errors on the model' do
            assigns(:supplier_framework_lot_rates).each_value do |supplier_framework_lot_rate|
              if supplier_framework_lot_rate.position_id == "RM6240.#{lot_number}.7"
                expect(supplier_framework_lot_rate.errors).to be_none
              else
                expect(supplier_framework_lot_rate.errors).to be_present
              end
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
        let(:model_params) { { enabled: false } }

        it 'redirects to the show page' do
          expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_datum_path(section:))
        end
      end
    end

    context 'when the lot number is 3' do
      let(:lot_number) { '3' }

      context 'and the section is lot_status' do
        let(:section) { 'lot_status' }
        let(:model_params) { { enabled: 'false' } }

        include_context 'when testing a section'

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the index page' do
            expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_data_path)
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
        let(:service_ids) { [] }
        let(:model_params) { { service_ids: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_service_ids' do
          expect(assigns(:supplier_framework_lot_service_ids)).to eq(supplier_framework_lot_services.map(&:service_id))
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_datum_path(section:))
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
        let(:rates) { Position.where(lot_id: "RM6240.#{lot_number}", mandatory: true).pluck(:id).index_with { '2345.67' } }
        let(:model_params) { { rates: } }

        include_context 'when testing a section'

        it 'assigns supplier_framework_lot_rates' do
          expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id.nil?] }).to eq(supplier_framework_lot_rates.map { |supplier_framework_lot_rate| [supplier_framework_lot_rate.position_id, false] } + [["RM6240.#{lot_number}.7", true]])
        end

        it 'assigns supplier_framework_lot_jurisdiction' do
          expect(assigns(:supplier_framework_lot_jurisdiction)).to eq(supplier_framework_lot_jurisdiction)
        end

        # rubocop:disable RSpec/NestedGroups
        context 'when it is valid' do
          it 'redirects to the show page' do
            expect(response).to redirect_to(legal_services_rm6240_admin_supplier_lot_datum_path(section:))
          end

          it 'updates the details' do
            updated_supplier_framework_lot_rates = supplier_framework_lot.rates.where(position_id: Position.where(lot_id: "RM6240.#{lot_number}").select(:id), supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction.id)

            expect(updated_supplier_framework_lot_rates.length).to eq(6)

            updated_supplier_framework_lot_rates.each do |rate|
              expect(rate.rate).to eq(234567)
            end
          end
        end

        context 'when it is invalid' do
          let(:rates) { Position.where(lot_id: "RM6240.#{lot_number}", mandatory: true).pluck(:id).index_with { '' } }

          render_views

          it 'has errors on the model' do
            assigns(:supplier_framework_lot_rates).each_value do |supplier_framework_lot_rate|
              if supplier_framework_lot_rate.position_id == "RM6240.#{lot_number}.7"
                expect(supplier_framework_lot_rate.errors).to be_none
              else
                expect(supplier_framework_lot_rate.errors).to be_present
              end
            end
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
