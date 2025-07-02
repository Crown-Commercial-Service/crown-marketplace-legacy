require 'rails_helper'

RSpec.describe LegalServices::Admin::UploadsHelper do
  describe 'get_error_details' do
    let(:error_details) { helper.get_error_details('legal_services.rm6240', error, details) }

    context 'when the error is supplier_missing_services' do
      let(:error) { :supplier_missing_services }
      let(:details) { ['Derrick Johnson & Sons', 'Bannas mighty MC', 'Alrest consultancy'] }

      it 'returns the correct error message' do
        expect(error_details).to eq 'The following suppliers do not offer any lots: <ul class="govuk-list govuk-list--bullet"><li>Derrick Johnson &amp; Sons</li><li>Bannas mighty MC</li><li>Alrest consultancy</li></ul> Make sure all the suppliers have the correct name and DUNS number'
      end
    end

    context 'when the error is supplier_missing_rates' do
      let(:error) { :supplier_missing_rates }
      let(:details) { ['Dunban MC (UK)'] }

      it 'returns the correct error message' do
        expect(error_details).to eq 'The following suppliers do not have any rate cards: <ul class="govuk-list govuk-list--bullet"><li>Dunban MC (UK)</li></ul> Make sure all the suppliers have the correct name and DUNS number'
      end
    end

    context 'when the error is supplier_rate_cards_has_incorrect_headers' do
      let(:error) { :supplier_rate_cards_has_incorrect_headers }
      let(:details) { ['Lot 1a - England & Wales', 'Lot 2b - Scotland', 'Lot 4'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect headers: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 1a - England &amp; Wales</li><li>Lot 2b - Scotland</li><li>Lot 4</li></ul> Make sure all sheets for 'Supplier rate cards' have the right catagories for the rates"
      end
    end

    context 'when the error is supplier_lot_1_service_offerings_has_incorrect_headers' do
      let(:error) { :supplier_lot_1_service_offerings_has_incorrect_headers }
      let(:details) { ['Lot 1b - Scotland'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect column headers: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 1b - Scotland</li></ul> Make sure all sheets for 'Supplier lot 1 service offerings' have the 40 expected services"
      end
    end

    context 'when the error is supplier_lot_2_service_offerings_has_incorrect_headers' do
      let(:error) { :supplier_lot_2_service_offerings_has_incorrect_headers }
      let(:details) { ['Lot 2a - England & Wales', 'Lot 2c - Northern Ireland'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect column  headers: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 2a - England &amp; Wales</li><li>Lot 2c - Northern Ireland</li></ul> Make sure all sheets for 'Supplier lot 2 service offerings' have the 15 expected services"
      end
    end

    context 'when the error is supplier_lot_3_service_offerings_has_incorrect_headers' do
      let(:error) { :supplier_lot_3_service_offerings_has_incorrect_headers }
      let(:details) { ['All regions'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "Make sure the sheet for 'Supplier lot 3 service offerings' only has the single service 'Transport (Rail) 3.1'"
      end
    end

    context 'when the error is supplier_rate_cards_has_empty_sheets' do
      let(:error) { :supplier_rate_cards_has_empty_sheets }
      let(:details) { ['Lot 2a - England & Wales', 'Lot 2c - Northern Ireland', 'Lot 3'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have no data: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 2a - England &amp; Wales</li><li>Lot 2c - Northern Ireland</li><li>Lot 3</li></ul> Make sure all sheets for 'Supplier rate cards' have been filled in"
      end
    end

    context 'when the error is supplier_lot_1_service_offerings_has_empty_sheets' do
      let(:error) { :supplier_lot_1_service_offerings_has_empty_sheets }
      let(:details) { ['North West England (NUTS D)', 'East Midlands (NUTS F)', 'East of England (NUTS H)'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have no data: <ul class=\"govuk-list govuk-list--bullet\"><li>North West England (NUTS D)</li><li>East Midlands (NUTS F)</li><li>East of England (NUTS H)</li></ul> Make sure all sheets for 'Supplier lot 1 service offerings' have been filled in"
      end
    end

    context 'when the error is supplier_lot_2_service_offerings_has_empty_sheets' do
      let(:error) { :supplier_lot_2_service_offerings_has_empty_sheets }
      let(:details) { ['Lot 2b - Scotland'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have no data: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 2b - Scotland</li></ul> Make sure all sheets for 'Supplier lot 2 service offerings' have been filled in"
      end
    end

    context 'when the error is supplier_lot_3_service_offerings_has_empty_sheets' do
      let(:error) { :supplier_lot_3_service_offerings_has_empty_sheets }
      let(:details) { ['All regions'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "Make sure the sheet for 'Supplier lot 3 service offerings' have been filled in"
      end
    end

    context 'when the error is file_check_failed' do
      let(:error) { :file_check_failed }
      let(:details) { 'File check error: Something went wrong' }

      it 'returns the correct error message' do
        expect(error_details).to eq 'Something went wrong when checking the files, the following error was returned: <br> <strong>File check error: Something went wrong</strong>'
      end
    end

    context 'when the error is file_process_failed' do
      let(:error) { :file_process_failed }
      let(:details) { 'File process error: Something went wrong' }

      it 'returns the correct error message' do
        expect(error_details).to eq 'Something went wrong when processing the files, the following error was returned: <br> <strong>File process error: Something went wrong</strong>'
      end
    end

    context 'when the error is file_publish_failed' do
      let(:error) { :file_publish_failed }
      let(:details) { 'File publish error: Something went wrong' }

      it 'returns the correct error message' do
        expect(error_details).to eq 'Something went wrong when publishing the files, the following error was returned: <br> <strong>File publish error: Something went wrong</strong>'
      end
    end

    context 'when the error is upload_failed' do
      let(:error) { :upload_failed }
      let(:details) { 'File upload error: Something went wrong' }

      it 'returns the correct error message' do
        expect(error_details).to eq 'Something went wrong with the file upload, the following error was returned: <br> <strong>File upload error: Something went wrong</strong>'
      end
    end
  end
end
