require 'rails_helper'

RSpec.describe LegalServices::RM6240::Admin::ReportExport do
  let(:framework) { Framework.find('RM6240') }
  let(:other_framework) { create(:framework) }
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_3) { create(:user) }
  let(:search_1) { create(:search, user: user_1, framework: framework, created_at: 6.days.ago, search_criteria: { 'central_government' => 'No', 'lot_number' => '1', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'a' }) }
  let(:search_2) { create(:search, user: user_2, framework: framework, created_at: 5.days.ago, search_criteria: { 'central_government' => 'No', 'lot_number' => '2', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'b' }) }
  let(:search_3) { create(:search, user: user_3, framework: framework, created_at: 4.days.ago, search_criteria: { 'central_government' => 'No', 'lot_number' => '3', 'service_numbers' => ['1', '2'] }) }
  let(:search_4) { create(:search, user: user_1, framework: framework, created_at: 3.days.ago, search_criteria: { 'central_government' => 'Yes', 'lot_number' => '1', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'b' }) }
  let(:search_5) { create(:search, user: user_2, framework: framework, created_at: 2.days.ago, search_criteria: { 'central_government' => 'Yes', 'lot_number' => '2', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'c' }) }
  let(:search_6) { create(:search, user: user_3, framework: framework, created_at: 1.day.ago, search_criteria: { 'central_government' => 'Yes', 'lot_number' => '3', 'service_numbers' => ['1', '2'] }) }
  let(:search_7) { create(:search, user: user_1, framework: framework, created_at: Time.now.in_time_zone('London'), search_criteria: { 'central_government' => 'No', 'lot_number' => '1', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'c' }) }
  let(:search_8) { create(:search, user: user_1, framework: other_framework, created_at: 3.days.ago, search_criteria: { 'central_government' => 'No', 'lot_number' => '2', 'service_numbers' => ['1', '2'], 'jurisdiction' => 'a' }) }

  before do
    allow(ReportWorker).to receive(:perform_async)

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

        it 'exludes that user from the result' do
          expect(result).to eq([search_6, search_4, search_3])
        end
      end
    end
  end

  describe '.create_headers_row' do
    let(:result) { described_class.send(:create_headers_row) }

    it 'returns the expected headers' do
      expect(result).to eq(['User ID', 'Search date', 'Central government', 'Lot', 'Services', 'Jurisdiction', 'Suppliers'])
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe '.create_search_row' do
    let(:result) { described_class.send(:create_search_row, search) }

    context 'when the search is for a normal lot' do
      let(:search) { search_1 }

      it 'has the lot, services and jurisdiction' do
        expect(result).to eq(
          [
            user_1.id,
            search.created_at.in_time_zone('London').strftime('%e %B %Y, %l:%M%P'),
            'No',
            'Lot 1 - Full service provision',
            "Administrative and Public Law;\nNon-Complex Finance and Investment",
            'England and Wales',
            "CHARLES;\nMABEL;\nOLIVER"
          ]
        )
      end
    end

    context 'when the search is for a normal lot for central government' do
      let(:search) { search_5 }

      it 'has the lot, services and jurisdiction' do
        expect(result).to eq(
          [
            user_2.id,
            search.created_at.in_time_zone('London').strftime('%e %B %Y, %l:%M%P'),
            'Yes',
            'Lot 2 - General service provision',
            "Property and Construction;\nSocial Housing",
            'Northern Ireland',
            "CHARLES;\nMABEL;\nOLIVER"
          ]
        )
      end
    end

    context 'when the search is for lot 3' do
      let(:search) { search_3 }

      it 'has the lot and services' do
        expect(result).to eq(
          [
            user_3.id,
            search.created_at.in_time_zone('London').strftime('%e %B %Y, %l:%M%P'),
            'No',
            'Lot 3 - Transport rail legal services',
            'Transport (Rail)',
            nil,
            "CHARLES;\nMABEL;\nOLIVER"
          ]
        )
      end
    end
  end
  # rubocop:enable RSpec/ExampleLength
end
