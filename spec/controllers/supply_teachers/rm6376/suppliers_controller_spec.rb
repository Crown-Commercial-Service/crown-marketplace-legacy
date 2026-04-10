require 'rails_helper'

RSpec.describe SupplyTeachers::RM6376::SuppliersController do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM6376' }

  login_st_buyer

  describe 'GET managed_service_providers' do
    let(:supplier_framework) { build(:supplier_framework) }
    let(:supplier_frameworks) { [supplier_framework] }

    before do
      allow(Supplier::Framework).to receive(:with_lots).with('RM6376.2').and_return(supplier_frameworks)

      get :managed_service_providers, params: {
        looking_for: 'managed_service_providers'
      }
    end

    it 'renders the managed_service_providers template' do
      expect(response).to render_template('managed_service_providers')
    end

    it 'assigns supplier_frameworks with managed service provider rates to supplier_frameworks' do
      expect(assigns(:supplier_frameworks)).to eq(supplier_frameworks)
    end

    it 'sets the back path to the looking-for question' do
      expected_path = journey_question_path(
        journey: 'supply-teachers',
        slug: 'looking-for',
        looking_for: 'managed_service_providers',
      )
      expect(assigns(:back_path)).to eq(expected_path)
    end
  end
end
