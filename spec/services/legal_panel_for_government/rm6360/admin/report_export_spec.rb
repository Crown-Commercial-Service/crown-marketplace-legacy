require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::ReportExport do
  let(:framework) { Framework.find('RM6360') }
  let(:other_framework) { create(:framework) }
  let(:user_1) { create(:user, :with_detail, email: 'izuku.midoriya@uahigh.ac.uk') }
  let(:user_2) { create(:user, :with_detail, email: 'katsuki.bakugo@uahigh.ac.uk') }
  let(:user_3) { create(:user, :with_detail, email: 'shoto.todoroki@uahigh.ac.uk') }
  let(:search_1) { create(:search, user: user_1, framework: framework, created_at: 6.days.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '12', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '12', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 123456, 'ccs_can_contact_you' => 'yes', 'lot_id' => 'RM6360.1', 'service_ids' => ['RM6360.1.1', 'RM6360.1.2'] }) }
  let(:search_2) { create(:search, user: user_2, framework: framework, created_at: 5.days.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '7', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '7', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 234567, 'ccs_can_contact_you' => 'no', 'lot_id' => 'RM6360.2', 'service_ids' => ['RM6360.2.1', 'RM6360.2.2'] }) }
  let(:search_3) { create(:search, user: user_3, framework: framework, created_at: 4.days.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '2', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '2', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 345678, 'ccs_can_contact_you' => 'yes', 'lot_id' => 'RM6360.3', 'service_ids' => ['RM6360.3.1', 'RM6360.3.2'] }) }
  let(:search_4) { create(:search, user: user_1, framework: framework, created_at: 3.days.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '9', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '9', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 456789, 'ccs_can_contact_you' => 'no', 'lot_id' => 'RM6360.4a', 'not_core_jurisdiction' => 'no', 'service_ids' => ['RM6360.4a.1', 'RM6360.4a.2'] }) }
  let(:search_5) { create(:search, user: user_2, framework: framework, created_at: 2.days.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '4', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '4', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 567890, 'ccs_can_contact_you' => 'yes', 'lot_id' => 'RM6360.4b', 'not_core_jurisdiction' => 'no', 'service_ids' => ['RM6360.4b.1', 'RM6360.4b.2'] }) }
  let(:search_6) { create(:search, user: user_3, framework: framework, created_at: 1.day.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '11', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '11', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 678901, 'ccs_can_contact_you' => 'no', 'lot_id' => 'RM6360.4c', 'not_core_jurisdiction' => 'yes', 'jurisdiction_ids' => ['CY', 'CZ'], 'service_ids' => ['RM6360.4c.1', 'RM6360.4c.2'] }) }
  let(:search_7) { create(:search, user: user_1, framework: framework, created_at: Time.now.in_time_zone('London'), search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '6', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '6', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 789012, 'ccs_can_contact_you' => 'yes', 'lot_id' => 'RM6360.5', 'service_ids' => ['RM6360.3.1', 'RM6360.3.2'] }) }
  let(:search_8) { create(:search, user: user_1, framework: other_framework, created_at: 3.days.ago, search_criteria: { 'requirement_start_date_day' => '1', 'requirement_start_date_month' => '1', 'requirement_start_date_year' => '2025', 'requirement_end_date_day' => '1', 'requirement_end_date_month' => '1', 'requirement_end_date_year' => '2026', 'requirement_estimated_total_value' => 890123, 'ccs_can_contact_you' => 'no', 'lot_id' => 'RM6360.4a', 'not_core_jurisdiction' => 'no', 'service_ids' => ['RM6360.4a.1', 'RM6360.4a.2'] }) }

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
    let(:previous_email) { nil }
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

        it 'exludes that user from the result' do
          expect(result).to eq([search_7, search_6, search_4, search_3, search_1])
        end
      end
    end

    context 'when the data range includes some of the searches' do
      let(:start_date) { 5.days.ago - 1.hour }
      let(:end_date) { 1.day.ago + 1.hour }

      it 'returns only the searches in that date range' do
        expect(result).to eq([search_6, search_5, search_4, search_3, search_2])
      end

      context 'when one of the user emails is in the TEST_USER_EMAILS list' do
        before { ENV['TEST_USER_EMAILS'] = user_2.email }

        after { ENV['TEST_USER_EMAILS'] = '' }

        it 'exludes that user from the result' do
          expect(result).to eq([search_6, search_4, search_3])
        end
      end
    end
  end

  describe '.create_headers_row' do
    let(:result) { described_class.send(:create_headers_row) }

    it 'returns the expected headers' do
      expect(result).to eq(['User ID', 'Search date', 'Name', 'Job title', 'Email address', 'Organisation name', 'Organisation sector', 'Requirements start date', 'Requirements end date', 'Requirements estimated total value', 'Opted in to be contacted', 'Lot', 'Services', 'Countries', 'Suppliers'])
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe '.create_search_row' do
    let(:result) { described_class.send(:create_search_row, search) }

    context 'when the search is for a normal lot' do
      let(:search) { search_1 }

      it 'has the lot and services' do
        expect(result).to eq(
          [
            user_1.id,
            search.created_at.in_time_zone('London').strftime('%e %B %Y, %l:%M%P'),
            'Izuku Midoriya',
            'One for all',
            'izuku.midoriya@uahigh.ac.uk',
            'Deku',
            'Culture, Media and Sport',
            '12/2025',
            '12/2026',
            '£123456',
            'Yes',
            'Lot 1 - Core Legal Services',
            "Assimilated Law;\nAviation and Airports",
            nil,
            "CHARLES;\nMABEL;\nOLIVER"
          ]
        )
      end
    end

    context 'when the search is for lot 4 but with core countries' do
      let(:search) { search_4 }

      it 'has the lot, services and core countries' do
        expect(result).to eq(
          [
            user_1.id,
            search.created_at.in_time_zone('London').strftime('%e %B %Y, %l:%M%P'),
            '',
            'One for all',
            '',
            'Deku',
            'Culture, Media and Sport',
            '9/2025',
            '9/2026',
            '£456789',
            'No',
            'Lot 4a - Trade and Investment Negotiations',
            "Assimilated Law;\nDomestic law of jurisdictions for trade",
            "Belgium;\nCanada;\nFrance;\nGermany;\nIreland;\nSwitzerland;\nUnited Kingdom;\nUnited States",
            "CHARLES;\nMABEL;\nOLIVER"
          ]
        )
      end
    end

    context 'when the search is for lot 4 but without core countries' do
      let(:search) { search_6 }

      it 'has the lot, services and core countries' do
        expect(result).to eq(
          [
            user_3.id,
            search.created_at.in_time_zone('London').strftime('%e %B %Y, %l:%M%P'),
            '',
            'Half-Cold Half-Hot',
            '',
            'Shoto',
            'Local Community and Housing',
            '11/2025',
            '11/2026',
            '£678901',
            'No',
            'Lot 4c - International Investment Disputes',
            "Domestic law of jurisdictions for trade;\nInternational arbitral awards",
            "Cyprus;\nCzechia",
            "CHARLES;\nMABEL;\nOLIVER"
          ]
        )
      end
    end
  end
  # rubocop:enable RSpec/ExampleLength
end
