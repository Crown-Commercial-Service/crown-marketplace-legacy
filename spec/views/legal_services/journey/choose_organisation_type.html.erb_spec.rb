require 'rails_helper'

RSpec.describe 'legal_services/journey/choose_organisation_type.html.erb' do
  let(:step) { LegalServices::Journey::ChooseOrganisationType.new }
  let(:errors) { ActiveModel::Errors.new(step) }
  let(:journey) { instance_double('Journey', errors: errors, previous_questions_and_answers: {}) }

  before do
    view.extend(ApplicationHelper)
    view.extend(JourneyHelper)
    assign(:journey, journey)
    assign(:form_path, '/')
  end

  it 'does not include aria-describedby attribute' do
    render
    expect(rendered).not_to have_css('fieldset[aria-describedby]')
  end

  it 'does not set the page title prefix' do
    render
    expect(view.content_for(:page_title_prefix)).to be_nil
  end

  context 'when the journey has an error' do
    before do
      errors.add(:central_government, 'error-message')
      render
    end

    it 'links the fieldset to the error message' do
      expect(rendered).to have_css('fieldset[aria-describedby="central_government-error"]')
    end

    it 'displays the error summary' do
      expect(rendered).to have_css('.govuk-error-summary')
    end

    it 'adds the form group error class' do
      expect(rendered).to have_css('.govuk-form-group.govuk-form-group--error')
    end

    it 'adds the message to the field with the error' do
      expect(rendered).to have_css('#central_government-error.govuk-error-message', text: 'error-message')
    end

    it 'adds an error prefix to the page title' do
      expect(view.content_for(:page_title_prefix)).to match(t('layouts.application.error_prefix'))
    end
  end
end
