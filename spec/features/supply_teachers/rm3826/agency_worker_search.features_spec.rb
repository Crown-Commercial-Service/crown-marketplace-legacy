require 'rails_helper'

RSpec.feature 'Agency workers', type: :feature, supply_teachers: true do
  include_context 'and RM6238 is live in the future'

  scenario 'Answers should not be pre-selected' do
    visit_supply_teachers_rm3826_start

    choose a_managed_service_provider
    click_on continue

    expect(page).not_to have_checked_field(an_individual_worker)
    expect(page).not_to have_checked_field(a_managed_service_provider)
  end

  scenario 'Buyer was looking for a nominated worker but changed mind' do
    visit_supply_teachers_rm3826_start

    choose an_individual_worker
    click_on continue

    choose yes
    click_on continue

    click_on back

    expect(page).to have_checked_field(yes)
  end

  scenario 'Buyer was looking for an agency supplied worker but changed mind' do
    visit_supply_teachers_rm3826_start

    choose an_individual_worker
    click_on continue

    choose no
    click_on continue

    click_on back

    expect(page).to have_checked_field(no)
  end

  def a_managed_service_provider
    I18n.t('supply_teachers.rm3826.journey.looking_for.answer_managed_service_provider')
  end

  def continue
    I18n.t('common.submit')
  end

  def an_individual_worker
    I18n.t('supply_teachers.rm3826.journey.looking_for.answer_worker')
  end

  def a_managed_service_provider
    I18n.t('supply_teachers.rm3826.journey.looking_for.answer_managed_service_provider')
  end

  def yes
    I18n.t('supply_teachers.journey.worker_type.answer.agency_supplied')
  end

  def back
    I18n.t('layouts.application.back')
  end

  def no
    I18n.t('supply_teachers.journey.worker_type.answer.nominated')
  end
end
