require 'rails_helper'

RSpec.describe 'supply_teachers/rm3826/home/index.html.erb' do
  it 'displays start button link' do
    allow(view).to receive(:params).and_return({ framework: 'RM3826' })

    render

    expect(rendered).to have_link(
      'Start now', href: journey_start_path(framework: 'RM3826', journey: 'supply-teachers')
    )
  end
end
