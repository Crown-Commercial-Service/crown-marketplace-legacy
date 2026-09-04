require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::CompareSelectSuppliers do
  subject(:step) do
    described_class.new(
      lot_number:,
      jurisdiction:,
      call_off_mechanism:,
      service_numbers:,
      supplier_framework_ids:
    )
  end

  let(:lot_number) { '1' }
  let(:jurisdiction) { 'a' }
  let(:call_off_mechanism) { 'direct_award' }
  let(:service_numbers) { %w[2 3] }
  let(:supplier_framework_ids) { ['supplier-uuid-1'] }

  describe 'attributes' do
    it { is_expected.to respond_to :lot_number }
    it { is_expected.to respond_to :jurisdiction }
    it { is_expected.to respond_to :call_off_mechanism }
    it { is_expected.to respond_to :service_numbers }
    it { is_expected.to respond_to :professions }
    it { is_expected.to respond_to :supplier_framework_ids }
  end

  describe 'validations' do
    context 'when call_off_mechanism is quotation_process' do
      let(:call_off_mechanism) { 'quotation_process' }

      context 'when fewer than 3 suppliers are selected' do
        let(:supplier_framework_ids) { ['supplier-uuid-1', 'supplier-uuid-2'] }

        it 'is not valid' do
          expect(step).not_to be_valid
        end

        it 'adds a minimum count error message requiring three suppliers' do
          step.valid?
          expect(step.errors[:supplier_framework_ids]).to include(
            'Please select a minimum of three suppliers for comparison'
          )
        end
      end

      context 'when 3 or more suppliers are selected' do
        let(:supplier_framework_ids) { ['supplier-uuid-1', 'supplier-uuid-2', 'supplier-uuid-3'] }

        it 'is valid' do
          expect(step).to be_valid
        end
      end
    end

    context 'when call_off_mechanism is not quotation_process' do
      let(:call_off_mechanism) { 'direct_award' }

      context 'when supplier_framework_ids is empty' do
        let(:supplier_framework_ids) { [] }

        it 'is not valid' do
          expect(step).not_to be_valid
        end

        it 'adds a minimum count error message requiring one supplier' do
          step.valid?
          expect(step.errors[:supplier_framework_ids]).to include(
            'Please select a minimum of one supplier for comparison'
          )
        end
      end

      context 'when at least one supplier_framework_id is provided' do
        let(:supplier_framework_ids) { ['supplier-uuid-1'] }

        it 'is valid' do
          expect(step).to be_valid
        end
      end
    end
  end

  describe '#lot' do
    let(:lot) { instance_double(Lot) }

    before do
      allow(Lot).to receive(:find).with('RM6374.1').and_return(lot)
    end

    it 'finds and returns the correct lot based on the lot_number' do
      expect(step.lot).to eq(lot)
    end
  end

  describe '#supplier_frameworks' do
    let(:lot) { instance_double(Lot, id: 'RM6374.1') }
    let(:selected_services) { %w[RM6374.1.2 RM6374.1.3] }
    let(:selected_jurisdiction_id) { 'RM6374.EW' }

    let(:supplier_z) { instance_double(Supplier, name: 'Zebra Law') }
    let(:supplier_a) { instance_double(Supplier, name: 'Alpha Legal') }

    let(:framework_z) { instance_double(Supplier::Framework, supplier: supplier_z, supplier_name: 'Zebra Law') }
    let(:framework_a) { instance_double(Supplier::Framework, supplier: supplier_a, supplier_name: 'Alpha Legal') }

    let(:frameworks_relation) { double('supplier_frameworks_relation') } # rubocop:disable RSpec/VerifiedDoubles

    before do
      allow(Lot).to receive(:find).with('RM6374.1').and_return(lot)
      allow(step).to receive(:get_service_numbers).with('1').and_return(selected_services) # rubocop:disable RSpec/SubjectStub
      allow(step).to receive(:get_jurisdiction).with('a').and_return(selected_jurisdiction_id) # rubocop:disable RSpec/SubjectStub

      allow(Supplier::Framework).to receive(:with_lots).with(lot.id).and_return(frameworks_relation)
      allow(frameworks_relation).to receive(:with_services_and_jurisdiction)
        .with(selected_services, [selected_jurisdiction_id])
        .and_return([framework_z, framework_a])
    end

    it 'returns all matching supplier frameworks sorted by supplier name regardless of supplier_framework_ids' do
      expect(step.send(:supplier_frameworks)).to eq([framework_a, framework_z])
    end

    context 'when lot_number is 6' do
      let(:lot_number) { '6' }
      let(:lot) { instance_double(Lot, id: 'RM6374.6') }

      before do
        allow(Lot).to receive(:find).with('RM6374.6').and_return(lot)
        allow(step).to receive(:get_service_numbers).with('6').and_return(selected_services) # rubocop:disable RSpec/SubjectStub

        allow(Supplier::Framework).to receive(:with_lots).with(lot.id).and_return(frameworks_relation)
        allow(frameworks_relation).to receive(:with_services)
          .with(selected_services)
          .and_return([framework_z, framework_a])
      end

      it 'fetches Lot 6 supplier frameworks sorted by supplier name' do
        expect(step.send(:supplier_frameworks)).to eq([framework_a, framework_z])
      end
    end
  end
end
