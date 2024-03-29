require 'rails_helper'

RSpec.describe Nuts1Region do
  subject(:region) { described_class.find_by(code: 'UKM') }

  let(:all_codes) { described_class.all.map(&:code) }

  it 'has a code and a name' do
    expect(region)
      .to have_attributes(code: 'UKM', name: 'Scotland')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to match_array(all_codes)
  end

  it 'has many NUTS 2 regions' do
    expect(region.nuts2_regions)
      .to have_attributes(length: 4)
  end
end
