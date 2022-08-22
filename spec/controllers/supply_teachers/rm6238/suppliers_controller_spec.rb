require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SuppliersController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM6238' }

  login_st_buyer

  include_context 'and RM3826 has expired'

  describe 'GET master_vendors' do
    let(:supplier) { build(:supply_teachers_rm6238_supplier) }
    let(:suppliers) { [supplier] }

    before do
      allow(SupplyTeachers::RM6238::Supplier).to receive(:with_master_vendor_rates).and_return(suppliers)

      get :master_vendors, params: {
        looking_for: 'master_vendor', threshold_position: 'above_threshold'
      }
    end

    it 'renders the master_vendors template' do
      expect(response).to render_template('master_vendors')
    end

    it 'assigns suppliers with master vendor rates to suppliers' do
      expect(assigns(:suppliers)).to eq(suppliers)
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
    let(:supplier) { build(:supply_teachers_rm6238_supplier) }
    let(:suppliers) { [supplier] }

    before do
      allow(SupplyTeachers::RM6238::Supplier).to receive(:with_education_technology_platforms_rates).and_return(suppliers)

      get :education_technology_platform_vendors, params: {
        looking_for: 'education_technology_platform'
      }
    end

    it 'renders the education_technology_platform_vendors template' do
      expect(response).to render_template('education_technology_platform_vendors')
    end

    it 'assigns suppliers with education technology platform vendor rates to suppliers' do
      expect(assigns(:suppliers)).to eq(suppliers)
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
    let(:branch) { create(:supply_teachers_rm6238_branch,  slug: 'branch-a') }
    let(:branch1) { create(:supply_teachers_rm6238_branch, slug: 'branch-b') }

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
      let(:framework) { 'RM3826' }

      it 'renders the unrecognised framework page with the right http status' do
        expect(response).to render_template('supply_teachers/home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
