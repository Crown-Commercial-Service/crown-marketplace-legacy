require 'rails_helper'

RSpec.describe 'supply_teachers/calculations/temp_to_perm_fee/_avoid_paying_fees.html.erb' do
  let(:calculator) do
    instance_double(
      'SupplyTeachers::RM3826::TempToPermCalculator::Calculator',
      hiring_after_12_weeks?: false,
      ideal_notice_date: ideal_notice_date,
      ideal_hire_date: ideal_hire_date
    )
  end

  let(:i18n_key) { 'supply_teachers.calculations.temp_to_perm_fee.avoid_paying_fees' }

  before do
    assign(:calculator, calculator)
    render 'supply_teachers/calculations/temp_to_perm_fee/avoid_paying_fees'
  end

  context 'when the ideal notice date is in the past' do
    let(:ideal_notice_date) { 5.months.ago }
    let(:ideal_hire_date) { 4.months.ago }

    it 'displays a generic notice to notify the agency' do
      expect(rendered).to have_content(I18n.t("#{i18n_key}.give_notice"))
      expect(rendered).to have_content(I18n.t("#{i18n_key}.make_the_worker_permanent"))
    end
  end

  context 'when the ideal notice date is in the future' do
    let(:ideal_notice_date) { 2.months.from_now }
    let(:ideal_hire_date) { 3.months.from_now }

    it 'displays the ideal hire and notice dates' do
      expect(rendered).to have_content(
        I18n.t("#{i18n_key}.avoid_fee",
               ideal_notice_date: ideal_notice_date.to_formatted_s(:long_with_day),
               ideal_hire_date: ideal_hire_date.to_formatted_s(:long_with_day))
      )
    end
  end
end
