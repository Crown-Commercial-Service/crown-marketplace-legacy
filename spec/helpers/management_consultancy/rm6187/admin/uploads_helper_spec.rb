require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::Admin::UploadsHelper do
  describe 'get_error_details' do
    let(:error_details) { helper.get_error_details('management_consultancy.rm6187', error, details) }

    context 'when the error is supplier_details_has_incorrect_headers' do
      let(:error) { :supplier_details_has_incorrect_headers }
      let(:details) { ['MCF3'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect headers: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF3</li></ul> Make sure all sheets for 'Supplier details' have the following headers: 'Supplier name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME?', 'DUNS Number'"
      end
    end

    context 'when the error is supplier_missing_lots' do
      let(:error) { :supplier_missing_lots }
      let(:details) { ['Derrick Johnson & Sons', 'Bannas mighty MC', 'Alrest consultancy'] }

      it 'returns the correct error message' do
        expect(error_details).to eq 'The following suppliers do not offer any lots: <ul class="govuk-list govuk-list--bullet"><li>Derrick Johnson &amp; Sons</li><li>Bannas mighty MC</li><li>Alrest consultancy</li></ul> Make sure all the suppliers have the correct name and DUNS number'
      end
    end

    context 'when the error is supplier_missing_rate_cards' do
      let(:error) { :supplier_missing_rate_cards }
      let(:details) { ['Dunban MC (UK)'] }

      it 'returns the correct error message' do
        expect(error_details).to eq 'The following suppliers do not have any rate cards: <ul class="govuk-list govuk-list--bullet"><li>Dunban MC (UK)</li></ul> Make sure all the suppliers have the correct name and DUNS number'
      end
    end

    context 'when the error is supplier_rate_cards_has_incorrect_headers' do
      let(:error) { :supplier_rate_cards_has_incorrect_headers }
      let(:details) { ['MCF3 Lot 3'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets are missing columns: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF3 Lot 3</li></ul> Make sure all sheets for 'Supplier rate cards' have the 10 expected columns"
      end
    end

    context 'when the error is supplier_service_offerings_has_incorrect_headers' do
      let(:error) { :supplier_service_offerings_has_incorrect_headers }
      let(:details) { ['MCF3 Lot 9'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect column headers: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF3 Lot 9</li></ul> Make sure all sheets for 'Supplier service offerings' have the correct services for their lot"
      end
    end

    context 'when the error is supplier_details_has_empty_sheets' do
      let(:error) { :supplier_details_has_empty_sheets }
      let(:details) { ['MCF3 Lot 4', 'MCF3 Lot 8'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have no data: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF3 Lot 4</li><li>MCF3 Lot 8</li></ul> Make sure all sheets for 'Supplier details' have been filled in"
      end
    end

    context 'when the error is supplier_rate_cards_has_empty_sheets' do
      let(:error) { :supplier_rate_cards_has_empty_sheets }
      let(:details) { ['MCF3 Lot 3', 'MCF3 Lot 7'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have no data: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF3 Lot 3</li><li>MCF3 Lot 7</li></ul> Make sure all sheets for 'Supplier rate cards' have been filled in"
      end
    end

    context 'when the error is supplier_service_offerings_has_empty_sheets' do
      let(:error) { :supplier_service_offerings_has_empty_sheets }
      let(:details) { ['MCF3 Lot 1', 'MCF3 Lot 5'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have no data: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF3 Lot 1</li><li>MCF3 Lot 5</li></ul> Make sure all sheets for 'Supplier service offerings' have been filled in"
      end
    end
  end

  describe 'upload_status_tag' do
    let(:status_tag) { helper.upload_status_tag(status) }

    context 'when the status is not_started' do
      let(:status) { 'not_started' }

      it 'returns in progress and grey' do
        expect(status_tag).to eq ['in progress', :grey]
      end
    end

    context 'when the status is in_progress' do
      let(:status) { 'in_progress' }

      it 'returns in progress and grey' do
        expect(status_tag).to eq ['in progress', :grey]
      end
    end

    context 'when the status is checking_files' do
      let(:status) { 'checking_files' }

      it 'returns in progress and grey' do
        expect(status_tag).to eq ['in progress', :grey,]
      end
    end

    context 'when the status is processing_files' do
      let(:status) { 'processing_files' }

      it 'returns in progress and grey' do
        expect(status_tag).to eq ['in progress', :grey]
      end
    end

    context 'when the status is checking_processed_data' do
      let(:status) { 'checking_processed_data' }

      it 'returns in progress and grey' do
        expect(status_tag).to eq ['in progress', :grey]
      end
    end

    context 'when the status is publishing_data' do
      let(:status) { 'publishing_data' }

      it 'returns in progress and grey' do
        expect(status_tag).to eq ['in progress', :grey]
      end
    end

    context 'when the status is published' do
      let(:status) { 'published' }

      it 'returns published on live' do
        expect(status_tag).to eq ['published on live']
      end
    end

    context 'when the status is failed' do
      let(:status) { 'failed' }

      it 'returns failed and red' do
        expect(status_tag).to eq ['failed', :red]
      end
    end
  end
end
