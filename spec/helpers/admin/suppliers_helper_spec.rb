require 'rails_helper'

RSpec.describe Admin::SuppliersHelper do
  describe '#customer_sector_selection_summary_rows' do
    let(:supplier_framework) { create(:supplier_framework) }
    let(:health_sector) { Sector.find_or_create_by!(name: 'Health') }
    let(:education_sector) { Sector.find_or_create_by!(name: 'Education') }

    context 'when the supplier has assigned sectors' do
      before do
        supplier_framework.sectors << [health_sector, education_sector]

        assign(:supplier_framework, supplier_framework)
      end

      it 'returns a formatted list of the assigned sectors' do
        result = helper.customer_sector_selection_summary_rows

        expect(result.to_s).to include('Health', 'Education')
      end
    end
  end
end
