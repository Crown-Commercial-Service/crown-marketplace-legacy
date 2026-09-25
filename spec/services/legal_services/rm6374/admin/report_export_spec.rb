require 'rails_helper'

RSpec.describe LegalServices::RM6374::Admin::ReportExport do
  let(:framework) { Framework.find('RM6374') }
  let(:other_framework) { create(:framework) }
  let(:user_1) { create(:user, :with_detail, email: 'izuku.midoriya@uahigh.ac.uk') }
  let(:user_2) { create(:user, :with_detail, email: 'katsuki.bakugo@uahigh.ac.uk') }
  let(:user_3) { create(:user, :with_detail, email: 'shoto.todoroki@uahigh.ac.uk') }

  let(:search_criteria_1) do
    {
      'lot_number' => '1a',
      'service_numbers' => ['1', '2'],
      'jurisdiction' => 'a',
      'requirement_start_date_month' => '01',
      'requirement_start_date_year' => '2027',
      'requirement_end_date_month' => '11',
      'requirement_end_date_year' => '2029',
      'requirement_estimated_total_value' => '199',
      'replaces_existing_contract' => 'yes',
      'requirement_being_awarded' => 'unlikely',
      'ccs_can_contact_you' => 'yes',
      'sector' => 'health'
    }
  end

  let(:search_criteria_3) do
    {
      'lot_number' => '6',
      'service_numbers' => ['6', '36'],
      'requirement_start_date_month' => '05',
      'requirement_start_date_year' => '2026',
      'requirement_end_date_month' => '05',
      'requirement_end_date_year' => '2028',
      'requirement_estimated_total_value' => '500',
      'replaces_existing_contract' => 'no',
      'requirement_being_awarded' => 'likely',
      'ccs_can_contact_you' => 'no',
      'sector' => 'education'
    }
  end

  let(:additional_details_full) do
    {
      'call_off_mechanism' => 'quotation_process',
      'results_downloaded' => true,
      'results_reviewed' => true,
      'comparison_result' => [['Supplier B', 'id-2'], ['Supplier A', 'id-1'], ['Supplier C', 'id-3']]
    }
  end

  let(:search_1) { create(:search, user: user_1, framework: framework, created_at: 6.days.ago, search_criteria: search_criteria_1, additional_details: additional_details_full) }
  let(:search_2) { create(:search, user: user_2, framework: framework, created_at: 5.days.ago, search_criteria: { 'lot_number' => '2', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'b' }) }
  let(:search_3) { create(:search, user: user_3, framework: framework, created_at: 4.days.ago, search_criteria: search_criteria_3) }
  let(:search_4) { create(:search, user: user_1, framework: framework, created_at: 3.days.ago, search_criteria: { 'lot_number' => '1b', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'b' }, additional_details: { 'results_downloaded' => false, 'results_reviewed' => false, 'comparison_result' => [['Supplier A', '1'], ['Supplier B', '2']] }) }
  let(:search_5) { create(:search, user: user_2, framework: framework, created_at: 2.days.ago, search_criteria: { 'lot_number' => '2', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'c' }) }
  let(:search_6) { create(:search, user: user_3, framework: framework, created_at: 1.day.ago, search_criteria: { 'lot_number' => '6', 'service_numbers' => ['6', '36'] }) }
  let(:search_7) { create(:search, user: user_1, framework: framework, created_at: Time.now.in_time_zone('London'), search_criteria: { 'lot_number' => '1c', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'c' }) }
  let(:search_8) { create(:search, user: user_1, framework: other_framework, created_at: 3.days.ago, search_criteria: { 'lot_number' => '2', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'a' }) }

  before do
    allow(ReportWorker).to receive(:perform_async)

    user_1.buyer_detail.update(name: 'Izuku Midoriya', job_title: 'One for all', organisation_name: 'Deku', organisation_sector: 'culture_media_and_sport')
    user_2.buyer_detail.update(name: 'Katsuki Bakugo', job_title: 'Explosion', organisation_name: 'Great Explosion Murder God Dynamight', organisation_sector: 'health')
    user_3.buyer_detail.update(name: 'Shoto Todoroki', job_title: 'Half-Cold Half-Hot', organisation_name: 'Shoto', organisation_sector: 'local_community_and_housing')

    search_1
    search_2
    search_3
    search_4
    search_5
    search_6
    search_7
  end

  describe '.call' do
    let(:result) { described_class.call(report) }
    let(:report) { create(:report, framework: framework, start_date: 6.days.ago - 1.hour, end_date: Time.now.in_time_zone('London')) }

    it 'creates a CSV string' do
      expect(result).to be_a String
    end
  end

  describe '.find_searches' do
    let(:report) { create(:report, framework:, start_date:, end_date:) }
    let(:result) { described_class.send(:find_searches, report) }

    context 'when the date range includes all of the searches' do
      let(:start_date) { 6.days.ago - 1.hour }
      let(:end_date) { Time.now.in_time_zone('London') }

      it 'returns all of the searches belonging to the framework' do
        expect(result).to eq([search_7, search_6, search_5, search_4, search_3, search_2, search_1])
      end

      context 'when one of the user emails is in the TEST_USER_EMAILS list' do
        before { ENV['TEST_USER_EMAILS'] = user_2.email }

        after { ENV['TEST_USER_EMAILS'] = '' }

        it 'excludes that user from the result' do
          expect(result).to eq([search_7, search_6, search_4, search_3, search_1])
        end
      end
    end

    context 'when the date range includes some of the searches' do
      let(:start_date) { 5.days.ago - 1.hour }
      let(:end_date) { 1.day.ago + 1.hour }

      it 'returns only the searches in that date range' do
        expect(result).to eq([search_6, search_5, search_4, search_3, search_2])
      end

      context 'when one of the user emails is in the TEST_USER_EMAILS list' do
        before { ENV['TEST_USER_EMAILS'] = user_2.email }

        after { ENV['TEST_USER_EMAILS'] = '' }

        it 'excludes that user from the result' do
          expect(result).to eq([search_6, search_4, search_3])
        end
      end
    end
  end

  describe '.search_criteria_headers' do
    it 'returns the expected search criteria headers' do # rubocop:disable RSpec/ExampleLength
      expect(described_class.search_criteria_headers).to eq(
        [
          'Name',
          'Job title',
          'Email address',
          'Organisation name',
          'Organisation sector',
          'Requirements start date',
          'Requirements end date',
          'Requirements estimated total value',
          'Replaces existing contract',
          'Award through GCA framework',
          'Opted in to be contacted',
          'Search sector',
          'Lot',
          'Services',
          'Jurisdiction'
        ]
      )
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe '.search_criteria_row' do
    let(:result) { described_class.search_criteria_row(search) }

    context 'when the search contains all criteria for a standard lot' do
      let(:search) { search_1 }

      it 'returns buyer details and search criteria' do
        expect(result).to eq(
          [
            'Izuku Midoriya',
            'One for all',
            'izuku.midoriya@uahigh.ac.uk',
            'Deku',
            'Culture, Media and Sport',
            '01/2027',
            '11/2029',
            '£199',
            'Yes',
            I18n.t('legal_services.rm6374.journey.information_about_your_requirement.requirement_being_awarded.options.unlikely'),
            'Yes',
            I18n.t('legal_services.rm6374.journey.choose_sector.options.health.label'),
            'Lot 1a - Full Legal Service Provision for all Public Sector',
            "Artificial Intelligence and Machine Learning Law;\nAssimilated Law",
            'England and Wales'
          ]
        )
      end
    end

    context 'when the search is for lot 6' do
      let(:search) { search_3 }

      it 'has the lot, services and All regions jurisdiction' do
        expect(result).to eq(
          [
            'Shoto Todoroki',
            'Half-Cold Half-Hot',
            'shoto.todoroki@uahigh.ac.uk',
            'Shoto',
            'Local Community and Housing',
            '05/2026',
            '05/2028',
            '£500',
            'No',
            I18n.t('legal_services.rm6374.journey.information_about_your_requirement.requirement_being_awarded.options.likely'),
            'No',
            I18n.t('legal_services.rm6374.journey.choose_sector.options.education.label'),
            'Lot 6 - Costs Lawyer Services',
            "Clinical Negligence Specialist Services;\nGeneral Costs Law Services",
            'All regions'
          ]
        )
      end
    end

    context 'when optional parameters are nil' do
      let(:search) do
        create(
          :search,
          user: user_1,
          framework: framework,
          search_criteria: {
            'lot_number' => '2',
            'jurisdiction' => 'b',
            'replaces_existing_contract' => nil,
            'requirement_being_awarded' => nil,
            'ccs_can_contact_you' => 'no',
            'sector' => nil
          }
        )
      end

      it 'handles nil values without raising errors' do # rubocop:disable RSpec/MultipleExpectations
        expect(result[8]).to be_nil
        expect(result[9]).to be_nil
        expect(result[10]).to eq('No')
        expect(result[11]).to be_nil
      end
    end
  end

  describe '.additional_details_headers' do
    it 'returns the expected additional details headers' do
      expect(described_class.additional_details_headers).to eq(
        [
          'Selected call off mechanism',
          'Results downloaded',
          "Suppliers' prospectus reviewed",
          'Suppliers selected for comparison'
        ]
      )
    end
  end

  describe '.additional_details_row' do
    let(:result) { described_class.additional_details_row(search) }

    context 'when additional details are fully populated' do
      let(:search) { search_1 }

      it 'returns mapped and sorted additional details' do
        expect(result).to eq(
          [
            'quotation_process',
            'Yes',
            'Yes',
            "Supplier A;\nSupplier B;\nSupplier C"
          ]
        )
      end
    end

    context 'when results_reviewed is false' do
      let(:search) { search_4 }

      it 'returns No for prospectus reviewed' do
        expect(result).to eq(
          [
            '',
            'No',
            'No',
            "Supplier A;\nSupplier B"
          ]
        )
      end
    end

    context 'when additional_details is nil' do
      let(:search) { create(:search, user: user_1, framework: framework, additional_details: nil) }

      it 'returns fallback values' do
        expect(result).to eq(['', 'No', '', ''])
      end
    end
  end
  # rubocop:enable RSpec/ExampleLength
end
