require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SuppliersHelper do
  describe 'show_path' do
    let(:supplier_framework) { create(:supplier_framework) }

    it 'returns the show path for the supplier' do
      expect(helper.show_path(supplier_framework)).to eq supply_teachers_rm6238_supplier_path(supplier_framework)
    end
  end
end
