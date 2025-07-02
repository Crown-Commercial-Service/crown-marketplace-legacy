require 'rails_helper'

RSpec.describe Jurisdiction do
  it 'has all the jurisdictions loaded' do
    expect(described_class.count).to eq(198)
  end
end
