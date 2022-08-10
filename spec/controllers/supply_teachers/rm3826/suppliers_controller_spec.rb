require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::SuppliersController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM3826' }

  login_st_buyer

  include_context 'and RM6238 is live in the future'

  describe 'GET master_vendors' do
    let(:supplier) { build(:supply_teachers_rm3826_supplier) }
    let(:suppliers) { [supplier] }

    before do
      allow(SupplyTeachers::RM3826::Supplier)
        .to receive(:with_master_vendor_rates).and_return(suppliers)
      get :master_vendors, params: {
        journey: 'supply-teachers',
        looking_for: 'master_vendor'
      }
    end

    it 'renders the master_vendors template' do
      expect(response).to render_template('master_vendors')
    end

    it 'assigns suppliers with master vendor rates to suppliers' do
      expect(assigns(:suppliers)).to eq(suppliers)
    end

    it 'sets the back path to the managed-service-provider question' do
      expected_path = journey_question_path(
        journey: 'supply-teachers',
        slug: 'looking-for',
        looking_for: 'master_vendor'
      )
      expect(assigns(:back_path)).to eq(expected_path)
    end
  end

  describe 'GET all suppliers' do
    let(:branch) { create(:supply_teachers_rm3826_branch,  slug: 'branch-a') }
    let(:branch1) { create(:supply_teachers_rm3826_branch, slug: 'branch-b') }

    before do
      get :all_suppliers, params: {
        journey: 'supply-teachers',
        looking_for: 'all_suppliers'
      }
    end

    it 'renders the all_suppliers template' do
      expect(response).to render_template('all_suppliers')
    end

    it 'assigns branches' do
      expect(assigns(:branches)).to eq([branch, branch1])
    end

    it 'sets the back path to the looking-for question' do
      expected_path = journey_question_path(
        journey: 'supply-teachers',
        slug: 'looking-for',
        looking_for: 'all_suppliers'
      )
      expect(assigns(:back_path)).to eq(expected_path)
    end

    context 'when the framework is not the current framework' do
      let(:framework) { 'RM6238' }

      it 'renders the unrecognised framework page with the right http status' do
        expect(response).to render_template('supply_teachers/home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
