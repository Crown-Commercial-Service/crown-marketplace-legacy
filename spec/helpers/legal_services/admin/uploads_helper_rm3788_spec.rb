require 'rails_helper'

RSpec.describe LegalServices::Admin::UploadsHelper, type: :helper do
  describe 'get_error_details' do
    let(:error_details) { helper.get_error_details('legal_services.rm3788', error, details) }

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
      let(:details) { ['Lot 1', 'Lot 2b - Scotland', 'Lot 4'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect headers: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 1</li><li>Lot 2b - Scotland</li><li>Lot 4</li></ul> Make sure all sheets for 'Supplier rate cards' have the right catagories for the rates"
      end
    end

    context 'when the error is supplier_lot_1_service_offerings_has_incorrect_headers' do
      let(:error) { :supplier_lot_1_service_offerings_has_incorrect_headers }
      let(:details) { ['North East England (NUTS C)', 'Yorkshire & Humberside (NUTS E)', 'West Midlands (NUTS G)'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect column headers: <ul class=\"govuk-list govuk-list--bullet\"><li>North East England (NUTS C)</li><li>Yorkshire &amp; Humberside (NUTS E)</li><li>West Midlands (NUTS G)</li></ul> Make sure all sheets for 'Supplier lot 1 service offerings' have the 14 expected services"
      end
    end

    context 'when the error is supplier_lot_2_service_offerings_has_incorrect_headers' do
      let(:error) { :supplier_lot_2_service_offerings_has_incorrect_headers }
      let(:details) { ['Lot 2a - England & Wales', 'Lot 2c - Northern Ireland'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect column  headers: <ul class=\"govuk-list govuk-list--bullet\"><li>Lot 2a - England &amp; Wales</li><li>Lot 2c - Northern Ireland</li></ul> Make sure all sheets for 'Supplier lot 2 service offerings' have the 35 expected services"
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
  end
end
