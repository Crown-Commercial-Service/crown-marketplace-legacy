require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Search do
  let(:user) { create(:user) }
  let(:framework) { Framework.find('RM6360') }
  let(:session_id) { SecureRandom.uuid }
  let(:suppliers) { [create(:supplier, name: 'Supplier A'), create(:supplier, name: 'Supplier B')] }
  let(:search_result) { suppliers.map { |supplier| create(:supplier_framework, supplier:, framework:) } }
  let(:comparison_result) { search_result.map { |supplier| [supplier, nil] } }
  let(:params) { ActionController::Parameters.new(search_criteria) }
  let(:existing_search) { described_class.create(**existing_search_details) }

  describe '.log_results_downloaded_to_search' do
    let(:result) { described_class.log_results_downloaded_to_search(framework, user, session_id, params) }
    let(:search_criteria) { { ccs_can_contact_you: 'yes', replaces_existing_contract: 'yes', central_government: 'yes', lot_id: 'RM6360.1', requirement_end_date_month: '10', requirement_end_date_year: '2025', requirement_estimated_total_value: '25000', requirement_start_date_month: '5', requirement_start_date_year: '2025', service_ids: ['RM6360.1.1', 'RM6360.1.3'] } }

    context 'when the search does not exist' do
      it 'has a falsey result' do
        expect(result).to be_falsey
      end

      it 'does not create a record' do
        expect { result }.not_to change(described_class, :count)
      end
    end

    context 'when a search does exist' do
      let(:existing_search_details) do
        {
          framework_id: framework.id,
          user_id: user.id,
          session_id: session_id,
          search_criteria: search_criteria,
          search_criteria_hash: 'f297ef6948a7d6e698379c433bd8a58fb0da6739df192589d3c2bef5acf2353b',
          search_result: search_result.map { |supplier_framework| [supplier_framework.supplier.name, supplier_framework.supplier.id] },
        }
      end

      before { existing_search }

      it 'has a truthy result' do
        expect(result).to be_truthy
      end

      it 'updates the additional details' do
        result

        expect(existing_search.reload.additional_details).to eq({ 'results_downloaded' => true })
      end

      context 'and the results have already been downloaded' do
        let(:existing_search_details) { super().merge({ additional_details: { 'results_downloaded' => true } }) }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end

        it 'does not update the record' do
          expect { result }.not_to change(existing_search, :updated_at)
        end
      end

      context 'and it is a different user' do
        let(:result) { described_class.log_results_downloaded_to_search(framework, new_user, session_id, params) }
        let(:new_user) { create(:user) }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end
      end

      context 'and it is a different session_id' do
        let(:result) { described_class.log_results_downloaded_to_search(framework, user, new_session_id, params) }
        let(:new_session_id) { SecureRandom.uuid }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end
      end

      context 'and it is a different search_criteria' do
        let(:result) { described_class.log_results_downloaded_to_search(framework, user, session_id, ActionController::Parameters.new(new_search_criteria)) }
        let(:new_search_criteria) { { criteria_1: false, criteria_2: false, criteria_3: 'Elma' } }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end
      end
    end
  end

  describe '.log_supplier_rates_comparison' do
    let(:result) { described_class.log_supplier_rates_comparison(framework, user, session_id, params, comparison_result) }
    let(:search_criteria) { { ccs_can_contact_you: 'yes', replaces_existing_contract: 'yes', central_government: 'yes', lot_id: 'RM6360.1', requirement_end_date_month: '10', requirement_end_date_year: '2025', requirement_estimated_total_value: '25000', requirement_start_date_month: '5', requirement_start_date_year: '2025', service_ids: ['RM6360.1.1', 'RM6360.1.3'], have_you_reviewed: 'No' } }

    context 'when the search does not exist' do
      it 'has a falsey result' do
        expect(result).to be_falsey
      end

      it 'does not create a record' do
        expect { result }.not_to change(described_class, :count)
      end
    end

    context 'when a search does exist' do
      let(:existing_search_details) do
        {
          framework_id: framework.id,
          user_id: user.id,
          session_id: session_id,
          search_criteria: search_criteria,
          search_criteria_hash: 'f297ef6948a7d6e698379c433bd8a58fb0da6739df192589d3c2bef5acf2353b',
          search_result: search_result.map { |supplier_framework| [supplier_framework.supplier.name, supplier_framework.supplier.id] },
        }
      end

      before { existing_search }

      it 'has a truthy result' do
        expect(result).to be_truthy
      end

      it 'updates the additional details' do
        result

        expect(existing_search.reload.additional_details).to eq({ 'results_reviewed' => false, 'comparison_result' => [['Supplier A', suppliers[0].id], ['Supplier B', suppliers[1].id]], })
      end

      context 'and the results have been reviewed' do
        let(:search_criteria) { super().merge({ have_you_reviewed: 'yes' }) }
        let(:comparison_result) { search_result[1..].map { |supplier| [supplier, nil] } }

        it 'has a truthy result' do
          expect(result).to be_truthy
        end

        it 'updates the additional details' do
          result

          expect(existing_search.reload.additional_details).to eq({ 'results_reviewed' => true, 'comparison_result' => [['Supplier B', suppliers[1].id]], })
        end
      end

      context 'and the results have already been compared' do
        let(:existing_search_details) { super().merge({ additional_details: { 'results_reviewed' => true, 'comparison_result' => [['Supplier A', suppliers[0].id]] } }) }

        it 'has a truthy result' do
          expect(result).to be_truthy
        end

        it 'updates the additional details' do
          result

          expect(existing_search.reload.additional_details).to eq({ 'results_reviewed' => false, 'comparison_result' => [['Supplier A', suppliers[0].id], ['Supplier B', suppliers[1].id]], })
        end
      end

      context 'and it is a different user' do
        let(:result) { described_class.log_supplier_rates_comparison(framework, new_user, session_id, params, comparison_result) }
        let(:new_user) { create(:user) }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end
      end

      context 'and it is a different session_id' do
        let(:result) { described_class.log_supplier_rates_comparison(framework, user, new_session_id, params, comparison_result) }
        let(:new_session_id) { SecureRandom.uuid }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end
      end

      context 'and it is a different search_criteria' do
        let(:result) { described_class.log_supplier_rates_comparison(framework, user, session_id, ActionController::Parameters.new(new_search_criteria), comparison_result) }
        let(:new_search_criteria) { { criteria_1: false, criteria_2: false, criteria_3: 'Elma' } }

        it 'has a falsey result' do
          expect(result).to be_falsey
        end
      end
    end
  end
end
