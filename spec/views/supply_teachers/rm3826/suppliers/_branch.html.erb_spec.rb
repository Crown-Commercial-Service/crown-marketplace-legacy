require 'rails_helper'

RSpec.describe 'supply_teachers/suppliers/_branch.html.erb' do
  let(:supplier) { create(:supply_teachers_rm3826_supplier) }
  let(:branch) { create(:supply_teachers_rm3826_branch, supplier: supplier) }

  before do
    view.params[:framework] = 'RM3826'

    render 'supply_teachers/suppliers/branch', branch: branch
  end

  it 'displays supplier and branch name' do
    expect(rendered).to have_text(supplier.name)
    expect(rendered).to have_text(branch.name)
  end
end
