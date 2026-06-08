require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::JurisdictionsController do
  let(:default_params) { { service: 'legal_panel_for_government/admin', framework: 'RM6360', supplier_id: supplier_framework.id, lot_number: lot_number } }

  let(:jurisdiction_ids) { ['DJ', 'ER', 'GF', 'GN', 'SX', 'FI', 'GR', 'AW', 'MS', 'KI', 'NC', 'SB', 'LC', 'AO', 'LU', 'TC', 'SH', 'MM', 'RO', 'BQ'] }
  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6360') }
  let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: "RM6360.#{lot_number}") }
  let!(:supplier_framework_lot_jurisdictions) { jurisdiction_ids.map { |jurisdiction_id| create(:supplier_framework_lot_jurisdiction, supplier_framework_lot:, jurisdiction_id:) } }
  let(:lot_number) { '4a' }
  let(:change_log) { ChangeLog.find_by(user_id: controller.current_user.id, framework_id: 'RM6360') }

  shared_examples 'when testing a view' do
    it 'assigns framework' do
      expect(assigns(:framework).id).to eq('RM6360')
    end

    it 'assigns supplier_framework' do
      expect(assigns(:supplier_framework).id).to eq(supplier_framework.id)
    end

    it 'assigns lot' do
      expect(assigns(:lot).id).to eq("RM6360.#{lot_number}")
    end

    it 'assigns supplier_framework_lot' do
      expect(assigns(:supplier_framework_lot).id).to eq(supplier_framework_lot.id)
    end

    it 'assigns section' do
      expect(assigns(:section)).to eq(:jurisdictions)
    end
  end

  describe 'GET edit' do
    login_ls_admin

    before { get :edit }

    include_context 'when testing a view'

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns model' do
      expect(assigns(:model).class).to eq(LegalPanelForGovernment::RM6360::Admin::ChangeJurisdictions)
    end
  end

  describe 'PUT update' do
    let(:add_or_remove) { 'add' }
    let(:jurisdiction_to_add) { 'BM' }
    let(:jurisdiction_to_remove) { nil }

    login_ls_admin

    before { put :update, params: { legal_panel_for_government_rm6360_admin_change_jurisdictions: { add_or_remove:, jurisdiction_to_add:, jurisdiction_to_remove:, } } }

    include_context 'when testing a view'

    it 'assigns model' do
      expect(assigns(:model).class).to eq(LegalPanelForGovernment::RM6360::Admin::ChangeJurisdictions)
    end

    context 'when it is valid' do
      context 'and the add_or_remove is add' do
        it 'redirects to the new page' do
          expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_new_path(jurisdiction_id: jurisdiction_to_add))
        end
      end

      context 'and the add_or_remove is remove' do
        let(:add_or_remove) { 'remove' }
        let(:jurisdiction_to_add) { nil }
        let(:jurisdiction_to_remove) { 'DJ' }

        it 'redirects to the delete page' do
          expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_delete_path(jurisdiction_id: jurisdiction_to_remove))
        end
      end
    end

    context 'when it is invalid' do
      let(:add_or_remove) { nil }

      it 'has errors on the model' do
        expect(assigns(:model).errors).to be_present
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET new' do
    login_ls_admin

    let(:jurisdiction_id) { 'BM' }

    before { get :new, params: { jurisdiction_id: } }

    include_context 'when testing a view'

    context 'when the jurisdiction already exists' do
      let(:jurisdiction_id) { 'DJ' }

      it 'redirects to the edit page' do
        expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
      end
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'builds supplier_framework_lot_jurisdiction' do
      expect(assigns(:supplier_framework_lot_jurisdiction).id).to be_nil
      expect(assigns(:supplier_framework_lot_jurisdiction).jurisdiction_id).to eq(jurisdiction_id)
    end

    it 'builds supplier_framework_lot_rates' do
      expect(assigns(:supplier_framework_lot_rates).length).to eq(13)
      expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).map { |position_id| [position_id, nil] })
    end
  end

  describe 'POST create' do
    login_ls_admin

    let(:jurisdiction_id) { 'BM' }
    let(:model_params) { { rates: Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).index_with { 123 } } }

    before { post :create, params: { jurisdiction_id: jurisdiction_id, supplier_framework_lot: model_params } }

    include_context 'when testing a view'

    context 'when the jurisdiction already exists' do
      let(:jurisdiction_id) { 'DJ' }

      it 'redirects to the edit page' do
        expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
      end
    end

    context 'when it is valid' do
      it 'redirects to the edit page' do
        expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
      end

      it 'sets the flash message' do
        expect(flash[:jurisdiction_added]).to eq('Bermuda')
      end

      it 'creates supplier_framework_lot_jurisdiction' do
        expect(assigns(:supplier_framework_lot_jurisdiction).id).not_to be_nil
        expect(assigns(:supplier_framework_lot_jurisdiction).jurisdiction_id).to eq(jurisdiction_id)
      end

      it 'creates supplier_framework_lot_rates' do
        created_supplier_framework_lot_rates = supplier_framework_lot.rates.where(position_id: Position.where(lot_id: "RM6360.#{lot_number}").select(:id), supplier_framework_lot_jurisdiction_id: assigns(:supplier_framework_lot_jurisdiction).id)

        expect(assigns(:supplier_framework_lot_rates).length).to eq(created_supplier_framework_lot_rates.length)

        created_supplier_framework_lot_rates.each do |rate|
          expect(rate.rate).to eq(12300)
        end
      end

      # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
      it 'creates a change log' do
        expect(change_log.change_type).to eq('add_rates_for_supplier_framework_lot_jurisdiction')
        expect(change_log.change_data['id']).to eq(supplier_framework_lot.id)
        expect(change_log.change_data['jurisdiction_id']).to eq(jurisdiction_id)
        expect(change_log.change_data['rates'].map { |rate_change| { position_id: rate_change['position_id'], before_rate: rate_change['before'].present?, after: rate_change['after'] } }).to eq(
          [
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.1' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.2' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.3' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.4' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.5' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.6' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.7' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.8' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.9' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.10' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.11' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.12' },
            { after: 12300, before_rate: false, position_id: 'RM6360.4a.13' }
          ]
        )
      end
      # rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
    end

    context 'when it is invalid' do
      let(:model_params) { { rates: Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).index_with { '' } } }

      it 'has errors on the model' do
        assigns(:supplier_framework_lot_rates).each_value do |supplier_framework_lot_rate|
          if supplier_framework_lot_rate.position_id.split('.')[2].to_i > 8
            expect(supplier_framework_lot_rate.errors).to be_none
          else
            expect(supplier_framework_lot_rate.errors).to be_present
          end
        end
      end

      it 'builds but does not create the supplier_framework_lot_jurisdiction' do
        expect(assigns(:supplier_framework_lot_jurisdiction).id).to be_nil
        expect(assigns(:supplier_framework_lot_jurisdiction).jurisdiction_id).to eq(jurisdiction_id)
      end

      it 'builds but does not create the supplier_framework_lot_rates' do
        expect(assigns(:supplier_framework_lot_rates).length).to eq(13)
        expect(assigns(:supplier_framework_lot_rates).map { |position_id, supplier_framework_lot_rate| [position_id, supplier_framework_lot_rate.id] }).to eq(Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).map { |position_id| [position_id, nil] })
      end

      it 'does not create a change log' do
        expect(change_log).to be_nil
      end
    end
  end

  describe 'GET delete' do
    login_ls_admin

    let(:jurisdiction_id) { 'DJ' }

    before { get :delete, params: { jurisdiction_id: } }

    include_context 'when testing a view'

    context 'when the jurisdiction does not exist' do
      let(:jurisdiction_id) { 'BM' }

      it 'redirects to the edit page' do
        expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
      end
    end

    it 'renders the delete template' do
      expect(response).to render_template(:delete)
    end

    it 'assigns supplier_framework_lot_jurisdiction' do
      expect(assigns(:supplier_framework_lot_jurisdiction).jurisdiction_id).to eq(jurisdiction_id)
    end
  end

  describe 'DELETE destroy' do
    login_ls_admin

    let(:jurisdiction_id) { 'DJ' }
    let!(:supplier_framework_lot_jurisdiction) { supplier_framework_lot_jurisdictions.find { |supplier_framework_lot_jurisdiction| supplier_framework_lot_jurisdiction.jurisdiction_id == jurisdiction_id } }
    let!(:supplier_framework_lot_rates) { Position.where(lot_id: "RM6360.#{lot_number}").pluck(:id).map { |position_id| create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, jurisdiction: supplier_framework_lot_jurisdiction, position_id: position_id) } }

    before { delete :destroy, params: { jurisdiction_id: } }

    include_context 'when testing a view'

    context 'when the jurisdiction does not exist' do
      let(:jurisdiction_id) { 'BM' }
      let(:supplier_framework_lot_jurisdiction) { nil }
      let(:supplier_framework_lot_rates) { nil }

      it 'redirects to the edit page' do
        expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
      end
    end

    it 'redirects to the edit page' do
      expect(response).to redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
    end

    it 'sets the flash message' do
      expect(flash[:jurisdiction_removed]).to eq('Djibouti')
    end

    it 'delete supplier_framework_lot_jurisdiction' do
      expect { Supplier::Framework::Lot::Jurisdiction.find(supplier_framework_lot_jurisdiction.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'deletes the supplier_framework_lot_rates' do
      supplier_framework_lot_rates.each do |supplier_framework_lot_rate|
        expect { Supplier::Framework::Lot::Rate.find(supplier_framework_lot_rate.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
    it 'creates a change log' do
      expect(change_log.change_type).to eq('remove_rates_for_supplier_framework_lot_jurisdiction')
      expect(change_log.change_data['id']).to eq(supplier_framework_lot.id)
      expect(change_log.change_data['jurisdiction_id']).to eq(jurisdiction_id)
      expect(change_log.change_data['rates'].map { |rate_change| { position_id: rate_change['position_id'], before_rate: rate_change['before'].present?, after_rate: rate_change['after'].present? } }).to eq(
        [
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.1' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.2' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.3' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.4' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.5' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.6' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.7' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.8' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.9' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.10' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.11' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.12' },
          { after_rate: false, before_rate: true, position_id: 'RM6360.4a.13' }
        ]
      )
    end
    # rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
  end
end
