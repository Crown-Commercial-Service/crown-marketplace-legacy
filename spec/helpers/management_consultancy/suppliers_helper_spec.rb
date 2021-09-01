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

  describe '.mc_lot_key' do
    let(:job_titles) do
      {
        junior: I18n.t("management_consultancy.job_titles.#{mc_lot_key(lot_number)}.junior"),
        standard: I18n.t("management_consultancy.job_titles.#{mc_lot_key(lot_number)}.standard"),
        senior: I18n.t("management_consultancy.job_titles.#{mc_lot_key(lot_number)}.senior"),
        principal: I18n.t("management_consultancy.job_titles.#{mc_lot_key(lot_number)}.principal"),
        managing: I18n.t("management_consultancy.job_titles.#{mc_lot_key(lot_number)}.managing"),
        director: I18n.t("management_consultancy.job_titles.#{mc_lot_key(lot_number)}.director")
      }
    end

    context 'when the lot is MCF1.2' do
      let(:lot_number) { 'MCF1.2' }

      it 'returns the correct job titles' do
        expect(job_titles).to eq({
                                   junior: 'Junior Accountant/Auditor',
                                   standard: 'Accountant/Auditor',
                                   senior: 'Senior Accountant/Auditor',
                                   principal: 'Principal Accountant/Auditor',
                                   managing: 'Managing Account/Auditor',
                                   director: 'Partner/Director Account/Auditor'
                                 })
      end
    end

    context 'when the lot is MCF1.3' do
      let(:lot_number) { 'MCF1.3' }

      it 'returns the correct job titles' do
        expect(job_titles).to eq({
                                   junior: 'Junior Auditor',
                                   standard: 'Lead Auditor',
                                   senior: 'Senior Auditor',
                                   principal: 'Audit Manager',
                                   managing: 'Senior Audit Manager',
                                   director: 'Partner/Director of Audit'
                                 })
      end
    end

    context 'when the lot starts with MCF1' do
      ['MCF1.4', 'MCF1.5', 'MCF1.6', 'MCF1.7', 'MCF1.8'].each do |lot|
        let(:lot_number) { lot }

        it "returns the correct job titles for the lot #{lot}" do
          expect(job_titles).to eq({
                                     junior: 'Junior Consultant',
                                     standard: 'Consultant',
                                     senior: 'Senior Consultant/Manager',
                                     principal: 'Principal Consultant',
                                     managing: 'Managing Consultant/Associate Director/Director',
                                     director: 'Partner/Managing Director'
                                   })
        end
      end
    end

    context 'when the lot starts with MCF2' do
      ['MCF2.1', 'MCF2.2', 'MCF2.3', 'MCF2.4'].each do |lot|
        let(:lot_number) { lot }

        it "returns the correct job titles for the lot #{lot}" do
          expect(job_titles).to eq({
                                     junior: 'Junior Consultant',
                                     standard: 'Consultant',
                                     senior: 'Senior Consultant/Manager',
                                     principal: 'Principal Consultant',
                                     managing: 'Managing Consultant/Associate Director/Director',
                                     director: 'Partner/Managing Director'
                                   })
        end
      end
    end

    context 'when the lot starts with MCF3' do
      ['MCF3.1', 'MCF3.2', 'MCF3.3', 'MCF3.4', 'MCF3.5', 'MCF3.6', 'MCF3.7', 'MCF3.8', 'MCF3.9'].each do |lot|
        let(:lot_number) { lot }

        it "returns the correct job titles for the lot #{lot}" do
          expect(job_titles).to eq({
                                     junior: 'Analyst / Junior Consultant',
                                     standard: 'Consultant',
                                     senior: 'Senior Consultant / Engagement Manager / Project Lead',
                                     principal: 'Principal Consultant / Associate Director',
                                     managing: 'Managing Consultant / Director',
                                     director: 'Partner'
                                   })
        end
      end
    end
  end
end
