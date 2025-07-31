require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::SuppliersComparisonController do
  let(:default_params) { { service: 'legal_panel_for_government', framework: framework } }
  let(:framework) { 'RM6360' }
  let(:supplier_frameworks) { create_list(:supplier_framework, 3, framework_id: framework) }
  let(:lot) { Lot.find(lot_id) }
  let(:services) { Service.where(lot_id:).sample(5) }
  let(:service_ids) { services.map(&:id) }
  let(:central_government) { 'yes' }
  let(:jurisdiction_ids) { ['GB'] }
  let(:supplier_framework_ids) { supplier_frameworks.pluck(:id) }
  let(:supplier_frameworks_relation) { instance_double(ActiveRecord::Relation) }

  login_ls_buyer

  before do
    allow(Supplier::Framework).to receive(:with_services_and_jurisdiction).with(service_ids, jurisdiction_ids).and_return(supplier_frameworks_relation)
    allow(supplier_frameworks_relation).to receive(:where).with(id: supplier_framework_ids).and_return(supplier_frameworks_relation)
    allow(supplier_frameworks_relation).to receive(:order).with('supplier.name').and_return(supplier_frameworks_relation)
    allow(supplier_frameworks_relation).to receive(:map).and_return(supplier_frameworks)
  end

  describe 'GET index' do
    before { get :index, params: }

    context 'when the lot answer is lot 1' do
      let(:lot_id) { 'RM6360.1' }

      let(:params) do
        {
          journey: 'legal_panel_for_government',
          lot_id: lot_id,
          service_ids: service_ids,
          central_government: central_government,
          supplier_framework_ids: supplier_framework_ids,
        }
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'assigns supplier_frameworks available in lot & regions, with services' do
        expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
      end

      it 'assigns lot to the correct lot' do
        expect(assigns(:lot)).to eq(lot)
      end

      it 'sets the back path to the select-suppliers-for-comparison question' do
        expected_path = journey_question_path(
          journey: 'legal-panel-for-government',
          slug: 'select-suppliers-for-comparison',
          lot_id: lot_id,
          service_ids: service_ids,
          central_government: central_government,
          supplier_framework_ids: supplier_framework_ids,
        )
        expect(assigns(:back_path)).to eq(expected_path)
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'makes the calls to supplier framework' do
        expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, ['GB'])
        expect(supplier_frameworks_relation).to have_received(:where).with(id: supplier_framework_ids)
        expect(supplier_frameworks_relation).to have_received(:order).with('supplier.name')
        expect(supplier_frameworks_relation).to have_received(:map)
      end
      # rubocop:enable RSpec/MultipleExpectations

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3788' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('legal_panel_for_government/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when the lot is RM6360.4a' do
      let(:lot_id) { 'RM6360.4a' }

      context 'and requirements are in a core jurisdiction' do
        let(:not_core_jurisdiction) { 'no' }

        let(:params) do
          {
            journey: 'legal_panel_for_government',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            central_government: central_government,
            supplier_framework_ids: supplier_framework_ids,
          }
        end

        it 'renders the index template' do
          expect(response).to render_template('index')
        end

        it 'assigns supplier_frameworks available in lot & regions, with services' do
          expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
        end

        it 'assigns lot to the correct lot' do
          expect(assigns(:lot)).to eq(lot)
        end

        it 'sets the back path to the select-suppliers-for-comparison question' do
          expected_path = journey_question_path(
            journey: 'legal-panel-for-government',
            slug: 'select-suppliers-for-comparison',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            central_government: central_government,
            supplier_framework_ids: supplier_framework_ids,
          )
          expect(assigns(:back_path)).to eq(expected_path)
        end

        # rubocop:disable RSpec/MultipleExpectations
        it 'makes the calls to supplier framework' do
          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, ['GB'])
          expect(supplier_frameworks_relation).to have_received(:where).with(id: supplier_framework_ids)
          expect(supplier_frameworks_relation).to have_received(:order).with('supplier.name')
          expect(supplier_frameworks_relation).to have_received(:map)
        end
        # rubocop:enable RSpec/MultipleExpectations
      end

      context 'and requirements are in a non-core jurisdiction' do
        let(:not_core_jurisdiction) { 'yes' }
        let(:jurisdiction_ids) { ['AE', 'AX'] }

        let(:params) do
          {
            journey: 'legal_panel_for_government',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            jurisdiction_ids: jurisdiction_ids,
            central_government: central_government,
            supplier_framework_ids: supplier_framework_ids,
          }
        end

        it 'renders the index template' do
          expect(response).to render_template('index')
        end

        it 'assigns supplier_frameworks available in lot & regions, with services' do
          expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
        end

        it 'assigns lot to the correct lot' do
          expect(assigns(:lot)).to eq(lot)
        end

        # rubocop:disable RSpec/ExampleLength
        it 'sets the back path to the select-suppliers-for-comparison question' do
          expected_path = journey_question_path(
            journey: 'legal-panel-for-government',
            slug: 'select-suppliers-for-comparison',
            lot_id: lot_id,
            service_ids: service_ids,
            not_core_jurisdiction: not_core_jurisdiction,
            jurisdiction_ids: jurisdiction_ids,
            central_government: central_government,
            supplier_framework_ids: supplier_framework_ids,
          )
          expect(assigns(:back_path)).to eq(expected_path)
        end
        # rubocop:enable RSpec/ExampleLength

        # rubocop:disable RSpec/MultipleExpectations
        it 'makes the calls to supplier framework' do
          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, ['AE', 'AX'])
          expect(supplier_frameworks_relation).to have_received(:where).with(id: supplier_framework_ids)
          expect(supplier_frameworks_relation).to have_received(:order).with('supplier.name')
          expect(supplier_frameworks_relation).to have_received(:map)
        end
        # rubocop:enable RSpec/MultipleExpectations
      end
    end
  end
end
