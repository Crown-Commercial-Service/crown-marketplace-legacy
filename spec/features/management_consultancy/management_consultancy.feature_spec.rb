require 'rails_helper'

RSpec.feature 'Management consultancy', type: :feature, management_consultancy: true do
  before do
    allow(Marketplace).to receive(:mcf3_live?).and_return(mcf3_live)

    supplier1 = create(:management_consultancy_supplier, name: 'Aardvark Ltd')
    supplier2 = create(:management_consultancy_supplier, name: 'Mega Group PLC')
    supplier3 = create(:management_consultancy_supplier, name: 'Johnson LLP')
    supplier4 = create(:management_consultancy_supplier, name: 'Pi Consulting')
    supplier5 = create(:management_consultancy_supplier, name: 'Nowhere Consulting')

    supplier1.service_offerings.create!(lot_number: 'MCF2.1', service_code: 'MCF2.1.1')
    supplier1.service_offerings.create!(lot_number: 'MCF2.1', service_code: 'MCF2.1.2')
    supplier1.service_offerings.create!(lot_number: 'MCF2.4', service_code: 'MCF2.4.10')
    supplier1.service_offerings.create!(lot_number: 'MCF3.1', service_code: 'MCF3.1.1')

    supplier2.service_offerings.create!(lot_number: 'MCF2.1', service_code: 'MCF2.1.3')
    supplier2.service_offerings.create!(lot_number: 'MCF2.2', service_code: 'MCF2.2.1')
    supplier2.service_offerings.create!(lot_number: 'MCF3.2', service_code: 'MCF3.2.2')
    supplier2.service_offerings.create!(lot_number: 'MCF3.3', service_code: 'MCF3.3.3')

    supplier3.service_offerings.create!(lot_number: 'MCF2.2', service_code: 'MCF2.2.2')
    supplier3.service_offerings.create!(lot_number: 'MCF2.2', service_code: 'MCF2.2.3')
    supplier3.service_offerings.create!(lot_number: 'MCF2.3', service_code: 'MCF2.3.10')
    supplier3.service_offerings.create!(lot_number: 'MCF3.4', service_code: 'MCF3.4.4')

    supplier4.service_offerings.create!(lot_number: 'MCF2.3', service_code: 'MCF2.3.2')
    supplier4.service_offerings.create!(lot_number: 'MCF2.4', service_code: 'MCF2.4.2')
    supplier4.service_offerings.create!(lot_number: 'MCF3.5', service_code: 'MCF3.5.6')
    supplier4.service_offerings.create!(lot_number: 'MCF3.5', service_code: 'MCF3.5.7')

    supplier5.service_offerings.create!(lot_number: 'MCF2.1', service_code: 'MCF2.1.1')
    supplier5.service_offerings.create!(lot_number: 'MCF2.1', service_code: 'MCF2.1.2')
    supplier5.service_offerings.create!(lot_number: 'MCF2.1', service_code: 'MCF2.1.3')
    supplier5.service_offerings.create!(lot_number: 'MCF3.7', service_code: 'MCF3.7.8')

    supplier1.regional_availabilities.create!(
      lot_number: 'MCF2.1', region_code: 'UKC1', expenses_required: true
    )
    supplier2.regional_availabilities.create!(
      lot_number: 'MCF2.2', region_code: 'UKC2', expenses_required: false
    )
    supplier3.regional_availabilities.create!(
      lot_number: 'MCF2.3', region_code: 'UKD1', expenses_required: false
    )
    supplier1.regional_availabilities.create!(
      lot_number: 'MCF2.4', region_code: 'UKD3', expenses_required: false
    )
  end

  context 'when mcf3_live is not live' do
    let(:mcf3_live) { false }

    scenario 'Buyer wants to buy business consultancy services (MCF2 Lot 1)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF2.1.1').first
      required_region = Nuts2Region.find_by(code: 'UKC1')

      click_on 'Confirm and continue'

      choose 'Lot 1 - Business consultancy'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      check required_region.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Aardvark Ltd/)
    end

    scenario 'Buyer wants to buy procurement, supply chain and commercial services (MCF2 Lot 2)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF2.2.1').first
      required_region = Nuts2Region.find_by(code: 'UKC2')

      click_on 'Confirm and continue'

      choose 'Lot 2 - Procurement, supply chain and commercial consultancy'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      check required_region.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Mega Group PLC/)
    end

    scenario 'Buyer wants to buy complex & transformation services (MCF2 Lot 3)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF2.3.10').first
      required_region = Nuts2Region.find_by(code: 'UKD1')

      click_on 'Confirm and continue'

      choose 'Lot 3 - Complex and transformation consultancy'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      check required_region.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Johnson LLP/)
    end

    scenario 'Buyer wants to buy strategic services (MCF2 Lot 4)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF2.4.10').first
      required_region = Nuts2Region.find_by(code: 'UKD3')

      click_on 'Confirm and continue'

      choose 'Lot 4 - Strategic consultancy'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      check required_region.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Aardvark Ltd/)
    end

    scenario 'check that only the correct options remain ticked' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF2.1.1').first
      wrong_service = ManagementConsultancy::Service.where(code: 'MCF2.1.2').first

      click_on 'Confirm and continue'

      choose 'Lot 1 - Business consultancy'
      click_on I18n.t('common.submit')

      check required_service.name
      check wrong_service.name
      click_on I18n.t('common.submit')

      click_on I18n.t('layouts.application.back')

      uncheck wrong_service.name
      click_on I18n.t('common.submit')

      click_on I18n.t('layouts.application.back')

      expect(page.find('input#service_MCF2-1-2')).not_to be_checked
    end
  end

  context 'when mcf3_live is live' do
    let(:mcf3_live) { true }

    scenario 'Buyer wants to buy business services (MCF3 Lot 1)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF3.1.1').first

      click_on 'Confirm and continue'

      choose 'Lot 1 - Business'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Aardvark Ltd/)
    end

    scenario 'Buyer wants to buy complex and transformation services (MCF3 Lot 3)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF3.3.3').first

      click_on 'Confirm and continue'

      choose 'Lot 3 - Complex and Transformation'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Mega Group PLC/)
    end

    scenario 'Buyer wants to buy finance services (MCF3 Lot 4)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF3.4.4').first

      click_on 'Confirm and continue'

      choose 'Lot 4 - Finance'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Johnson LLP/)
    end

    scenario 'Buyer wants to buy health, social care and community services (MCF2 Lot 7)' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF3.7.8').first

      click_on 'Confirm and continue'

      choose 'Lot 7 - Health, Social Care and Community'
      click_on I18n.t('common.submit')

      check required_service.name
      click_on I18n.t('common.submit')

      expect(page).to have_css('h1', text: 'Supplier results')
      expect(page).to have_text('1 company')
      expect(page).to have_text(/Nowhere Consulting/)
    end

    scenario 'check that only the correct options remain ticked' do
      visit_management_consultancy_start

      required_service = ManagementConsultancy::Service.where(code: 'MCF3.5.6').first
      wrong_service = ManagementConsultancy::Service.where(code: 'MCF3.5.7').first

      click_on 'Confirm and continue'

      choose 'Lot 5 - HR'
      click_on I18n.t('common.submit')

      check required_service.name
      check wrong_service.name
      click_on I18n.t('common.submit')

      click_on I18n.t('layouts.application.back')

      uncheck wrong_service.name
      click_on I18n.t('common.submit')

      click_on I18n.t('layouts.application.back')

      expect(page.find('input#service_MCF3-5-7')).not_to be_checked
    end
  end
end
