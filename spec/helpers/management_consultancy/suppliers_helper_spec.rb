require 'rails_helper'

RSpec.describe ManagementConsultancy::SuppliersHelper, type: :helper do
  describe '.eoi_document_link' do
    context 'when the lot starts with MCF1' do
      ['MCF1.2', 'MCF1.3', 'MCF1.4', 'MCF1.5', 'MCF1.6', 'MCF1.7', 'MCF1.8'].each do |lot|
        it "returns the link for the RM3745 MCF when the lot is #{lot}" do
          expect(eoi_document_link(lot)).to eq I18n.t('management_consultancy.suppliers.download.expression_of_interest_template_link_1')
        end
      end
    end

    context 'when the lot starts with MCF2' do
      ['MCF2.1', 'MCF2.2', 'MCF2.3', 'MCF2.4'].each do |lot|
        it "returns the link for the RM6008 MCF2 when the lot is #{lot}" do
          expect(eoi_document_link(lot)).to eq I18n.t('management_consultancy.suppliers.download.expression_of_interest_template_link_2')
        end
      end
    end

    context 'when the lot starts with MCF3' do
      ['MCF3.1', 'MCF3.2', 'MCF3.3', 'MCF3.4', 'MCF3.5', 'MCF3.6', 'MCF3.7', 'MCF3.8', 'MCF3.9'].each do |lot|
        it "returns the link for the RM6008 MCF2 when the lot is #{lot}" do
          expect(eoi_document_link(lot)).to eq I18n.t('management_consultancy.suppliers.download.expression_of_interest_template_link_3')
        end
      end
    end
  end
end
