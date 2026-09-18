require 'rails_helper'

RSpec.describe Admin::SuppliersHelper, type: :helper do
  describe '#customer_sector_selection_summary_rows' do
    let(:supplier_framework) { create(:supplier_framework) }
    let(:health_sector) { create(:sector, name: 'Health') }
    let(:education_sector) { create(:sector, name: 'Education') }

    context 'when the supplier has assigned sectors' do
      before do
        supplier_framework.sectors << [health_sector, education_sector]
      end

      it 'returns a formatted list of the assigned sectors' do
        result = helper.customer_sector_selection_summary_rows(supplier_framework)
        expect(result).to include('Health', 'Education')
      end
    end
  end
end