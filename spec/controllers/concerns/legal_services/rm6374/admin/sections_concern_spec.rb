require 'rails_helper'

RSpec.describe LegalServices::RM6374::Admin::SectionsConcern do
  let(:dummy_class) do
    Class.new do
      include LegalServices::RM6374::Admin::SectionsConcern
    end
  end

  let(:instance) { dummy_class.new }

  describe '#permitted_section_params' do
    context 'when the section is customer_sector_selection' do
      let(:section) { 'customer_sector_selection' }

      it 'permits an array of sector_ids' do
        params = instance.permitted_section_params(section)
        
        expect(params).to eq([{ sector_ids: [] }])
      end
    end
  end
end