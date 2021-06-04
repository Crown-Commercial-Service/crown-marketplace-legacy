require 'rails_helper'

RSpec.describe ManagementConsultancy::Admin::UploadsHelper, type: :helper do
  describe 'get_error_details' do
    let(:error_details) { helper.get_error_details(error, details) }

    context 'when the error is supplier_details_headers_incorrect' do
      let(:error) { :supplier_details_headers_incorrect }
      let(:details) { ['MCF', 'MCF3'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect headers: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF</li><li>MCF3</li></ul> Make sure all sheets for 'Supplier details' have the following headers: 'Supplier name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME?', 'DUNS Number'"
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

    context 'when the error is supplier_rate_cards_missing_column' do
      let(:error) { :supplier_rate_cards_missing_column }
      let(:details) { ['MCF Lot 2', 'MCF2 Lot 2', 'MCF3 Lot 3'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets are missing columns: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF Lot 2</li><li>MCF2 Lot 2</li><li>MCF3 Lot 3</li></ul> Make sure all sheets for 'Supplier rate cards' have the 10 expected columns"
      end
    end

    context 'when the error is supplier_regional_offerings_headers_incorrect' do
      let(:error) { :supplier_regional_offerings_headers_incorrect }
      let(:details) { ['MCF Lot 3', 'MCF2 Lot 1', 'MCF3 Lot 4'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect headers: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF Lot 3</li><li>MCF2 Lot 1</li><li>MCF3 Lot 4</li></ul> Make sure all sheets for 'Supplier regional offerings' have the correct regions"
      end
    end

    context 'when the error is supplier_service_offering_missing_rows' do
      let(:error) { :supplier_service_offering_missing_rows }
      let(:details) { ['MCF Lot 5', 'MCF2 Lot 4', 'MCF3 Lot 9'] }

      it 'returns the correct error message' do
        expect(error_details).to eq "The following sheets have incorrect column headers: <ul class=\"govuk-list govuk-list--bullet\"><li>MCF Lot 5</li><li>MCF2 Lot 4</li><li>MCF3 Lot 9</li></ul> Make sure all sheets for 'Supplier regional offerings' have the correct services for their lot"
      end
    end
  end
end
