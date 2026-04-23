require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SuppliersController do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM6238' }

  login_st_buyer

  include_context 'and RM6238 is live'

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
      create(:supplier_framework_lot, supplier_framework: supplier_framework_1, lot_id: lot_id)
      create(:supplier_framework_lot, supplier_framework: supplier_framework_2, lot_id: lot_id)

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
    let(:paginated_supplier_names) { assigns(:supplier_frameworks).map(&:supplier_name) }

    before do
      supplier_framework_1 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'aaa'))
      supplier_framework_2 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'aab'))
      supplier_framework_3 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'zzy'))
      supplier_framework_4 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'zzz'))

      supplier_framework_lot_1 = create(:supplier_framework_lot, supplier_framework: supplier_framework_1, lot_id: lot_id)
      supplier_framework_lot_2 = create(:supplier_framework_lot, supplier_framework: supplier_framework_2, lot_id: lot_id)
      supplier_framework_lot_3 = create(:supplier_framework_lot, supplier_framework: supplier_framework_3, lot_id: lot_id)
      supplier_framework_lot_4 = create(:supplier_framework_lot, supplier_framework: supplier_framework_4, lot_id: lot_id)

      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_1, position_id: 'RM6238.1')
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_2, position_id: 'RM6238.1')
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_3, position_id: 'RM6238.1')
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_4, position_id: 'RM6238.1')

      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_1, location: Geocoding.point(latitude: 51.5201, longitude: -0.0759))
      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_2, location: Geocoding.point(latitude: 55.9619, longitude: -3.1953))
      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_3, location: Geocoding.point(latitude: 55.9619, longitude: -3.1953))
      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_4, location: Geocoding.point(latitude: 51.5201, longitude: -0.0759))

      Geocoder::Lookup::Test.add_stub(
        agency_postcode, [{ 'coordinates' => [51.5201, -0.0759] }]
      )

      post :search_all_suppliers, params: { agency_name:, agency_postcode: }
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    context 'when nothing is searched' do
      let(:agency_name) { nil }
      let(:agency_postcode) { nil }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has all suppliers in the list' do
        expect(paginated_supplier_names).to contain_exactly('aaa', 'aab', 'zzy', 'zzz')
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'renders the _agencies_table partial' do
          expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
        end

        it 'renders the json with the expected keys' do
          expect(response.content_type).to eq('application/json; charset=utf-8')

          expect(response.parsed_body['html'].is_a?(String)).to be true
        end

        it 'has only the london suppliers in the list' do
          expect(paginated_supplier_names).to contain_exactly('aaa', 'zzz')
        end
      end
    end

    context 'when "a" is searched' do
      let(:agency_name) { 'a' }
      let(:agency_postcode) { nil }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has just aaa and aab in the list' do
        expect(paginated_supplier_names).to contain_exactly('aaa', 'aab')
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'renders the _agencies_table partial' do
          expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
        end

        it 'renders the json with the expected keys' do
          expect(response.content_type).to eq('application/json; charset=utf-8')

          expect(response.parsed_body['html'].is_a?(String)).to be true
        end

        it 'has only the london supplier in the list' do
          expect(paginated_supplier_names).to contain_exactly('aaa')
        end
      end
    end

    context 'when "z" is searched' do
      let(:agency_name) { 'z' }
      let(:agency_postcode) { nil }

      it 'renders the _agencies_table partial' do
        expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
      end

      it 'renders the json with the expected keys' do
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(response.parsed_body['html'].is_a?(String)).to be true
      end

      it 'has just zzy and zzz in the list' do
        expect(paginated_supplier_names).to contain_exactly('zzy', 'zzz')
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'renders the _agencies_table partial' do
          expect(response).to render_template('supply_teachers/suppliers/_agencies_table')
        end

        it 'renders the json with the expected keys' do
          expect(response.content_type).to eq('application/json; charset=utf-8')

          expect(response.parsed_body['html'].is_a?(String)).to be true
        end

        it 'has only the london supplier in the list' do
          expect(paginated_supplier_names).to contain_exactly('zzz')
        end
      end
    end

    context 'when "l" is searched' do
      let(:agency_name) { 'l' }
      let(:agency_postcode) { nil }

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

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

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
end
