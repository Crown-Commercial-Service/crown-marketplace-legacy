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
        looking_for: 'managed_service_provider', managed_service_provider: 'master_vendor', threshold_position: 'above_threshold'
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
        slug: 'master-vendor-options',
        looking_for: 'managed_service_provider',
        managed_service_provider: 'master_vendor',
        threshold_position: 'above_threshold'
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
