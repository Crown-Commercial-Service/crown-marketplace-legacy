require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SuppliersController do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM6238' }

  login_st_buyer

  describe 'GET master_vendors' do
    let(:supplier_framework) { build(:supplier_framework) }
    let(:supplier_frameworks) { [supplier_framework] }

    before do
      allow(Supplier::Framework).to receive(:with_lots).with('RM6238.2.2').and_return(supplier_frameworks)

      get :master_vendors, params: {
        looking_for: 'master_vendor', threshold_position: 'above_threshold'
      }
    end

    it 'renders the master_vendors template' do
      expect(response).to render_template('master_vendors')
    end

    it 'assigns supplier_frameworks with master vendor rates to supplier_frameworks' do
      expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
    end

    it 'sets the back path to the master-vendor-options question' do
      expected_path = journey_question_path(
        journey: 'supply-teachers',
        slug: 'master-vendor-options',
        looking_for: 'master_vendor',
        threshold_position: 'above_threshold'
      )
      expect(assigns(:back_path)).to eq(expected_path)
    end
  end

  describe 'GET education_technology_platform_vendors' do
    let(:supplier_framework) { build(:supplier_framework) }
    let(:supplier_frameworks) { [supplier_framework] }

    before do
      allow(Supplier::Framework).to receive(:with_lots).with('RM6238.4').and_return(supplier_frameworks)

      get :education_technology_platform_vendors, params: {
        looking_for: 'education_technology_platform'
      }
    end

    it 'renders the education_technology_platform_vendors template' do
      expect(response).to render_template('education_technology_platform_vendors')
    end

    it 'assigns supplier_frameworks with education technology platform vendor rates to supplier_frameworks' do
      expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
    end

    it 'sets the back path to the looking-for question' do
      expected_path = journey_question_path(
        journey: 'supply-teachers',
        slug: 'looking-for',
        looking_for: 'education_technology_platform'
      )
      expect(assigns(:back_path)).to eq(expected_path)
    end
  end

  describe 'GET all suppliers' do
    let(:lot_id) { 'RM6238.1' }
    let(:supplier_framework_1) { create(:supplier_framework, framework_id: 'RM6238') }
    let(:supplier_framework_2) { create(:supplier_framework, framework_id: 'RM6238') }

    before do
      create(:supplier_framework_lot, supplier_framework: supplier_framework_1, lot_id: lot_id, jurisdiction_id: 'GB')
      create(:supplier_framework_lot, supplier_framework: supplier_framework_2, lot_id: lot_id, jurisdiction_id: 'GB')

      get :all_suppliers, params: {
        journey: 'supply-teachers',
        looking_for: 'all_suppliers'
      }
    end

    it 'renders the all_suppliers template' do
      expect(response).to render_template('all_suppliers')
    end

    # rubocop:disable RSpec/ExampleLength
    it 'assigns supplier_frameworks' do
      expect(assigns(:supplier_frameworks).map do |supplier_framework|
        {
          supplier_framework_id: supplier_framework.id,
          name: supplier_framework.supplier_name
        }
      end).to match_array([supplier_framework_1, supplier_framework_2].map do |supplier_framework|
        {
          supplier_framework_id: supplier_framework.id,
          name: supplier_framework.supplier_name
        }
      end)
    end
    # rubocop:enable RSpec/ExampleLength

    it 'sets the back path to the looking-for question' do
      expected_path = journey_question_path(
        journey: 'supply-teachers',
        slug: 'looking-for',
        looking_for: 'all_suppliers'
      )
      expect(assigns(:back_path)).to eq(expected_path)
    end

    context 'when the framework is not the current framework' do
      let(:framework) { 'RM3826' }

      it 'renders the unrecognised framework page with the right http status' do
        expect(response).to render_template('supply_teachers/home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST search_all_suppliers' do
    let(:lot_id) { 'RM6238.1' }
    let(:supplier_framework_1) { create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'aaa')) }
    let(:supplier_framework_2) { create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'zzz')) }
    let(:paginated_supplier_names) { assigns(:supplier_frameworks).map(&:supplier_name) }

    before do
      create(:supplier_framework_lot, supplier_framework: supplier_framework_1, lot_id: lot_id, jurisdiction_id: 'GB')
      create(:supplier_framework_lot, supplier_framework: supplier_framework_2, lot_id: lot_id, jurisdiction_id: 'GB')

      post :search_all_suppliers, params: { agency_name: }
    end

    context 'when nothing is searched' do
      let(:agency_name) { nil }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has all suppliers in the list' do
        expect(paginated_supplier_names).to contain_exactly('aaa', 'zzz')
      end
    end

    context 'when "a" is searched' do
      let(:agency_name) { 'a' }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has just aaa in the list' do
        expect(paginated_supplier_names).to contain_exactly('aaa')
      end
    end

    context 'when "z" is searched' do
      let(:agency_name) { 'z' }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has just zzz in the list' do
        expect(paginated_supplier_names).to contain_exactly('zzz')
      end
    end

    context 'when "l" is searched' do
      let(:agency_name) { 'l' }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has no suppliers in the list' do
        expect(paginated_supplier_names).to be_empty
      end
    end
  end
end
