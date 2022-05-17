require 'rails_helper'

RSpec.describe 'supply_teachers/rm3826/suppliers/all_suppliers.html.erb' do
  let(:supplier) { create(:supply_teachers_rm3826_supplier) }
  let(:branch) { create(:supply_teachers_rm3826_branch, supplier: supplier) }

  before do
    assign(:branches, SupplyTeachers::RM3826::Branch.all.page)
    assign(:branches_count, 10)
  end

  it 'displays all agencies page' do
    render
    expect(rendered).to have_text(/All agencies/)
    expect(rendered).to have_text(/There are 10 agencies currently available/)
  end
end
