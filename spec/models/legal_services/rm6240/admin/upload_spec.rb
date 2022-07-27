require 'rails_helper'

RSpec.describe LegalServices::RM6240::Admin::Upload, type: :model do
  let(:upload) { create(:legal_services_rm6240_admin_upload) }
  let(:valid_file) { Tempfile.new(['valid_file', '.xlsx']) }
  let(:text_file) { Tempfile.new(['text_file', '.txt']) }
  let(:invalid_file) { Tempfile.new(['invalid_file', '.xlsx']) }
  let(:valid_file_path) { fixture_file_upload(valid_file.path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  let(:text_file_path) { fixture_file_upload(text_file.path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  let(:invalid_file_path) { fixture_file_upload(invalid_file.path, 'application/pdft') }

  after do
    valid_file.unlink
    text_file.unlink
    invalid_file.unlink
  end

  describe 'validations' do
    context 'when considering if the files are attached' do
      context 'and no files are attached' do
        it 'is not valid and has the correct error messages' do
          expect(upload.valid?(:upload)).to be false
          expect(upload.errors.messages.values.flatten).to match ["Select the 'Supplier details' file", "Select the 'Supplier rate cards' file", "Select the 'Supplier lot 1 service offerings' file", "Select the 'Supplier lot 2 service offerings' file", "Select the 'Supplier lot 3 service offerings' file"]
        end
      end

      context 'and three files are attached' do
        before do
          upload.supplier_rate_cards_file = valid_file_path
          upload.supplier_lot_1_service_offerings_file = valid_file_path
          upload.supplier_lot_3_service_offerings_file = valid_file_path
        end

        it 'is not valid and has the correct error messages' do
          expect(upload.valid?(:upload)).to be false
          expect(upload.errors.messages.values.flatten).to match ["Select the 'Supplier details' file", "Select the 'Supplier lot 2 service offerings' file"]
        end
      end
    end

    context 'when considering the file extension' do
      context 'and no files have the correct file extension' do
        before do
          upload.supplier_details_file = text_file_path
          upload.supplier_rate_cards_file = text_file_path
          upload.supplier_lot_1_service_offerings_file = text_file_path
          upload.supplier_lot_2_service_offerings_file = text_file_path
          upload.supplier_lot_3_service_offerings_file = text_file_path
        end

        it 'is not valid and has the correct error messages' do
          expect(upload.valid?(:upload)).to be false
          expect(upload.errors.messages.values.flatten).to match ["The 'Supplier details' file must be an XLSX", "The 'Supplier rate cards' file must be an XLSX", "The 'Supplier lot 1 service offerings' file must be an XLSX", "The 'Supplier lot 2 service offerings' file must be an XLSX", "The 'Supplier lot 3 service offerings' file must be an XLSX"]
        end
      end

      context 'and three files have the correct file extension' do
        before do
          upload.supplier_details_file = valid_file_path
          upload.supplier_rate_cards_file = text_file_path
          upload.supplier_lot_1_service_offerings_file = text_file_path
          upload.supplier_lot_2_service_offerings_file = valid_file_path
          upload.supplier_lot_3_service_offerings_file = text_file_path
        end

        it 'is not valid and has the correct error messages' do
          expect(upload.valid?(:upload)).to be false
          expect(upload.errors.messages.values.flatten).to match ["The 'Supplier rate cards' file must be an XLSX", "The 'Supplier lot 1 service offerings' file must be an XLSX", "The 'Supplier lot 3 service offerings' file must be an XLSX"]
        end
      end
    end

    context 'when considering the file content type' do
      context 'and no files have the correct content type' do
        before do
          upload.supplier_details_file = invalid_file_path
          upload.supplier_rate_cards_file = invalid_file_path
          upload.supplier_lot_1_service_offerings_file = invalid_file_path
          upload.supplier_lot_2_service_offerings_file = invalid_file_path
          upload.supplier_lot_3_service_offerings_file = invalid_file_path
        end

        it 'is not valid and has the correct error messages' do
          expect(upload.valid?(:upload)).to be false
          expect(upload.errors.messages.values.flatten).to match ["The 'Supplier details' file does not contain the expected content type", "The 'Supplier rate cards' file does not contain the expected content type", "The 'Supplier lot 1 service offerings' file does not contain the expected content type", "The 'Supplier lot 2 service offerings' file does not contain the expected content type", "The 'Supplier lot 3 service offerings' file does not contain the expected content type"]
        end
      end

      context 'and three files have the correct content type' do
        before do
          upload.supplier_details_file = valid_file_path
          upload.supplier_rate_cards_file = invalid_file_path
          upload.supplier_lot_1_service_offerings_file = valid_file_path
          upload.supplier_lot_2_service_offerings_file = invalid_file_path
          upload.supplier_lot_3_service_offerings_file = valid_file_path
        end

        it 'is not valid and has the correct error messages' do
          expect(upload.valid?(:upload)).to be false
          expect(upload.errors.messages.values.flatten).to match ["The 'Supplier rate cards' file does not contain the expected content type", "The 'Supplier lot 2 service offerings' file does not contain the expected content type"]
        end
      end
    end

    context 'and all files are valid' do
      before do
        upload.supplier_details_file = valid_file_path
        upload.supplier_rate_cards_file = valid_file_path
        upload.supplier_lot_1_service_offerings_file = valid_file_path
        upload.supplier_lot_2_service_offerings_file = valid_file_path
        upload.supplier_lot_3_service_offerings_file = valid_file_path
      end

      it 'is valid' do
        expect(upload.valid?(:upload)).to be true
      end
    end
  end

  describe 'aasm_state' do
    it 'starts in the not_started state' do
      expect(upload.aasm_state).to eq('not_started')
    end

    context 'when start_upload is called' do
      before do
        allow(LegalServices::RM6240::FileUploadWorker).to receive(:perform_async).with(upload.id).and_return(true)
        upload.start_upload!
      end

      pending 'changes the state to in_progress' do
        expect(upload.in_progress?).to be true
      end

      pending 'starts the worker' do
        expect(LegalServices::RM6240::FileUploadWorker).to have_received(:perform_async).with(upload.id)
      end
    end

    context 'when check_files is called' do
      before { upload.update(aasm_state: 'in_progress') }

      it 'changes the state to checking_files' do
        upload.check_files!

        expect(upload.checking_files?).to be true
      end
    end

    context 'when process_files is called' do
      before { upload.update(aasm_state: 'checking_files') }

      it 'changes the state to processing_files' do
        upload.process_files!

        expect(upload.processing_files?).to be true
      end
    end

    context 'when check_processed_data is called' do
      before { upload.update(aasm_state: 'processing_files') }

      it 'changes the state to checking_processed_data' do
        upload.check_processed_data!

        expect(upload.checking_processed_data?).to be true
      end
    end

    context 'when publish_data is called' do
      before { upload.update(aasm_state: 'checking_processed_data') }

      it 'changes the state to publishing_data' do
        upload.publish_data!

        expect(upload.publishing_data?).to be true
      end
    end

    context 'when publish is called' do
      before { upload.update(aasm_state: 'publishing_data') }

      it 'changes the state to published' do
        upload.publish!

        expect(upload.published?).to be true
      end
    end

    context 'when fail is called' do
      it 'changes the state to failed' do
        upload.fail!

        expect(upload.failed?).to be true
      end
    end
  end

  describe 'short_uuid' do
    it 'contains the first half of the uuid' do
      expect(upload.id).to start_with upload.short_uuid
    end
  end

  describe 'latest_upload' do
    context 'and there are published uploads' do
      before { 5.times { described_class.create(aasm_state: 'published') } }

      it 'is the latest published upload' do
        expect(described_class.latest_upload).to eq described_class.all.order(:created_at).first
      end
    end

    context 'and there are no published uploads' do
      before { 5.times { described_class.create } }

      it 'is nil' do
        expect(described_class.latest_upload).to be_nil
      end
    end
  end
end
