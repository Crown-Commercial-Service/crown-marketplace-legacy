require 'rails_helper'

RSpec.describe LegalServices::RM6374::Admin::SectionsConcern do
  let(:dummy_class) do
    Class.new(ApplicationController) do
      include LegalServices::RM6374::Admin::SectionsConcern
    end
  end

  let(:instance) { dummy_class.new }

  describe '#section_attributes' do
    context 'when the section is customer_sector_selection' do
      let(:section) { :customer_sector_selection }

      it 'permits an array of sector_ids' do
        params = instance.send(:section_attributes, section)

        expect(params).to eq([{ sector_ids: [] }])
      end
    end
  end
end