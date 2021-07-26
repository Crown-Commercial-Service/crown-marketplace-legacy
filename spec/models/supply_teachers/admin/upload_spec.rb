require 'rails_helper'

RSpec.describe SupplyTeachers::Admin::Upload, type: :model do
  let(:blank_upload) { build(:supply_teachers_admin_upload) }
  let(:valid_xlsx_file) { Tempfile.new(['valid_xlsx_file', '.xlsx']) }
  let(:valid_csv_file) { Tempfile.new(['valid_csv_file', '.csv']) }
  let(:invalid_file) { Tempfile.new(['invalid_file', '.xlsx']) }
  let(:valid_xlsx_file_path) { fixture_file_upload(valid_xlsx_file.path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  let(:valid_csv_file_path) { fixture_file_upload(valid_csv_file.path, 'text/csv') }
  let(:invalid_xlsx_file_extension_path) { fixture_file_upload(valid_csv_file.path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  let(:invalid_csv_file_extension_path) { fixture_file_upload(valid_xlsx_file.path, 'text/csv') }
  let(:invalid_xlsx_file_content_path) { fixture_file_upload(valid_xlsx_file.path, 'text/csv') }
  let(:invalid_csv_file_content_path) { fixture_file_upload(valid_csv_file.path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  let(:invalid_file_path) { fixture_file_upload(invalid_file.path, 'application/pdft') }

  let(:upload) do
    build(:supply_teachers_admin_upload) do |admin_upload|
      admin_upload.current_accredited_suppliers = valid_xlsx_file_path
      admin_upload.pricing_for_tool = valid_xlsx_file_path
      admin_upload.save
    end
  end

  after do
    valid_xlsx_file.unlink
    valid_csv_file.unlink
    invalid_file.unlink
  end

  describe 'validations' do
    context 'when considering if the files are attached' do
      context 'and no files are attached' do
        it 'is not valid and has the correct error messages' do
          expect(blank_upload.save).to be false
          expect(blank_upload.errors.messages.values.flatten).to match ['Upload at least one file']
        end
      end
    end

    context 'when considering the file extension' do
      context 'and no files have the correct file extension' do
        before do
          blank_upload.current_accredited_suppliers = invalid_xlsx_file_extension_path
          blank_upload.geographical_data_all_suppliers = invalid_xlsx_file_extension_path
          blank_upload.lot_1_and_lot_2_comparisons = invalid_xlsx_file_extension_path
          blank_upload.master_vendor_contacts = invalid_csv_file_extension_path
          blank_upload.neutral_vendor_contacts = invalid_csv_file_extension_path
          blank_upload.pricing_for_tool = invalid_xlsx_file_extension_path
          blank_upload.supplier_lookup = invalid_csv_file_extension_path
        end

        it 'is not valid and has the correct error messages' do
          expect(blank_upload.save).to be false
          expect(blank_upload.errors.messages.values.flatten).to match ["The 'Current accredited suppliers' file must be an XLSX", "The 'Geographical data all suppliers' file must be an XLSX", "The 'Lot 1 and lot 2 comparisons' file must be an XLSX", "The 'Master vendor contacts' file must be a CSV", "The 'Neutral vendor contacts' file must be a CSV", "The 'Pricing for tool' file must be an XLSX", "The 'Supplier lookup' file must be a CSV"]
        end
      end
    end

    context 'when considering the file content type' do
      context 'and no files have the correct content type' do
        before do
          blank_upload.current_accredited_suppliers = invalid_xlsx_file_content_path
          blank_upload.geographical_data_all_suppliers = invalid_xlsx_file_content_path
          blank_upload.lot_1_and_lot_2_comparisons = invalid_xlsx_file_content_path
          blank_upload.master_vendor_contacts = invalid_csv_file_content_path
          blank_upload.neutral_vendor_contacts = invalid_csv_file_content_path
          blank_upload.pricing_for_tool = invalid_xlsx_file_content_path
          blank_upload.supplier_lookup = invalid_csv_file_content_path
        end

        it 'is not valid and has the correct error messages' do
          expect(blank_upload.save).to be false
          expect(blank_upload.errors.messages.values.flatten).to match ["The 'Current accredited suppliers' file does not contain the expected content type", "The 'Geographical data all suppliers' file does not contain the expected content type", "The 'Lot 1 and lot 2 comparisons' file does not contain the expected content type", "The 'Master vendor contacts' file does not contain the expected content type", "The 'Neutral vendor contacts' file does not contain the expected content type", "The 'Pricing for tool' file does not contain the expected content type", "The 'Supplier lookup' file does not contain the expected content type"]
        end
      end
    end

    context 'when all uploaded files are valid' do
      context 'and two files are attached' do
        before do
          blank_upload.current_accredited_suppliers = valid_xlsx_file_path
          blank_upload.supplier_lookup = valid_csv_file_path
        end

        it 'is valid' do
          expect(upload.save).to be true
        end
      end

      context 'and all 7 files are attached' do
        before do
          blank_upload.current_accredited_suppliers = valid_xlsx_file_path
          blank_upload.geographical_data_all_suppliers = valid_xlsx_file_path
          blank_upload.lot_1_and_lot_2_comparisons = valid_xlsx_file_path
          blank_upload.master_vendor_contacts = valid_csv_file_path
          blank_upload.neutral_vendor_contacts = valid_csv_file_path
          blank_upload.pricing_for_tool = valid_xlsx_file_path
          blank_upload.supplier_lookup = valid_csv_file_path
        end

        it 'is valid' do
          expect(upload.save).to be true
        end
      end
    end
  end

  describe '#default scope' do
    it 'orders by descending created_at' do
      expect(described_class.all.to_sql).to eq described_class.all.order(created_at: :desc).to_sql
    end
  end

  describe '#aasm state' do
    it 'starts at not_started state' do
      expect(upload).to have_state(:not_started)
    end

    context 'when start_upload is called' do
      before do
        allow(SupplyTeachers::DataImportWorker).to receive(:perform_async).with(upload.id).and_return(true)
        upload.start_upload!
      end

      it 'changes the state to processing_files' do
        expect(upload).to have_state(:processing_files)
      end

      it 'starts the worker' do
        expect(SupplyTeachers::DataImportWorker).to have_received(:perform_async).with(upload.id)
      end
    end

    context 'when files_processing_complete is called' do
      before { upload.update(aasm_state: 'processing_files') }

      it 'changes the state to files_processed' do
        upload.files_processing_complete!

        expect(upload).to have_state(:files_processed)
      end
    end

    context 'when approve is called' do
      before do
        upload.update(aasm_state: 'files_processed')
        allow(SupplyTeachers::DataUploadWorker).to receive(:perform_async).with(upload.id).and_return(true)
        upload.approve!
      end

      it 'changes the state to uploading' do
        expect(upload).to have_state(:uploading)
      end

      it 'starts the worker' do
        expect(SupplyTeachers::DataUploadWorker).to have_received(:perform_async).with(upload.id)
      end
    end

    context 'when publish is called' do
      before { upload.update(aasm_state: 'uploading') }

      it 'changes the state to published' do
        upload.publish!

        expect(upload).to have_state(:published)
      end
    end

    context 'when reject is called' do
      before do
        upload.update(aasm_state: 'files_processed')
        allow(upload).to receive(:cleanup_input_files)
        upload.reject!
      end

      it 'changes the state to rejected' do
        expect(upload).to have_state(:rejected)
      end

      it 'does cleanup files' do
        expect(upload).to have_received(:cleanup_input_files)
      end
    end

    context 'when cancel is called' do
      before do
        upload.update(aasm_state: 'files_processed')
        allow(upload).to receive(:cleanup_input_files)
        upload.cancel!
      end

      it 'changes the state to canceled' do
        expect(upload).to have_state(:canceled)
      end

      it 'does cleanup files' do
        expect(upload).to have_received(:cleanup_input_files)
      end
    end

    context 'when fail is called' do
      before do
        upload.update(aasm_state: 'uploading')
        allow(upload).to receive(:cleanup_input_files)
        upload.fail!
      end

      it 'changes the state to fail' do
        expect(upload).to have_state(:failed)
      end

      it 'does cleanup files' do
        expect(upload).to have_received(:cleanup_input_files)
      end
    end
  end

  describe '#available_for_cp' do
    let(:new_upload) { build(:supply_teachers_admin_upload) }

    context 'when no previous upload exists' do
      it 'returns false for current_accredited_suppliers' do
        expect(new_upload.send(:available_for_cp, nil, :current_accredited_suppliers)).to eq false
      end

      it 'returns false for pricing_for_tool' do
        expect(new_upload.send(:available_for_cp, nil, :pricing_for_tool)).to eq false
      end
    end

    context 'when previous approved upload exists' do
      before do
        new_upload.current_accredited_suppliers = valid_xlsx_file_path
        new_upload.pricing_for_tool = valid_xlsx_file_path
        upload.update(aasm_state: 'published')
      end

      it 'returns true for current_accredited_suppliers' do
        expect(new_upload.send(:available_for_cp, upload.current_accredited_suppliers, :current_accredited_suppliers)).to eq true
      end

      it 'returns false for geographical_data_all_suppliers' do
        expect(new_upload.send(:available_for_cp, upload.geographical_data_all_suppliers, :geographical_data_all_suppliers)).to eq false
      end

      it 'returns false for lot_1_and_lot_2_comparisons' do
        expect(new_upload.send(:available_for_cp, upload.lot_1_and_lot_2_comparisons, :lot_1_and_lot_2_comparisons)).to eq false
      end

      it 'returns false for master_vendor_contacts' do
        expect(new_upload.send(:available_for_cp, upload.master_vendor_contacts, :master_vendor_contacts)).to eq false
      end

      it 'returns false for neutral_vendor_contacts' do
        expect(new_upload.send(:available_for_cp, upload.neutral_vendor_contacts, :neutral_vendor_contacts)).to eq false
      end

      it 'returns true for pricing_for_tool' do
        expect(new_upload.send(:available_for_cp, upload.pricing_for_tool, :pricing_for_tool)).to eq true
      end

      it 'returns false for supplier_lookup' do
        expect(new_upload.send(:available_for_cp, upload.supplier_lookup, :supplier_lookup)).to eq false
      end
    end
  end

  describe '#files_count' do
    context 'when one file' do
      before do
        blank_upload.current_accredited_suppliers = valid_xlsx_file_path
        blank_upload.save
      end

      it 'returns 1' do
        expect(blank_upload.files_count).to eq(1)
      end
    end
  end

  describe '#previous_uploaded_file_upload' do
    context 'when there is a previous approved upload' do
      before { upload.update(aasm_state: 'published') }

      it 'returns previous approved object with uploaded file' do
        expect(described_class.previous_uploaded_file_upload(:current_accredited_suppliers)).to eq upload
        expect(described_class.previous_uploaded_file_upload(:pricing_for_tool)).to eq upload
      end

      it 'returns nil if file is not there' do
        expect(described_class.previous_uploaded_file_upload(:master_vendor_contacts)).to eq nil
      end
    end

    context 'when there is no previous upload that is approved' do
      it 'returns nil' do
        expect(described_class.previous_uploaded_file_upload(:pricing_for_tool)).to eq nil
      end
    end
  end

  describe '#reject_previous_uploads' do
    before do
      upload.update(aasm_state: state)
      new_upload = build(:supply_teachers_admin_upload)
      new_upload.current_accredited_suppliers = valid_xlsx_file_path
      new_upload.save
      upload.reload
    end

    context 'when there is previous upload in not_started state' do
      let(:state) { 'not_started' }

      it 'cancels the upload' do
        expect(upload).to have_state(:canceled)
      end
    end

    context 'when there is previous upload in processing_files state' do
      let(:state) { 'processing_files' }

      it 'cancels the upload' do
        expect(upload).to have_state(:canceled)
      end
    end

    context 'when there is previous upload in files_processed state' do
      let(:state) { 'files_processed' }

      it 'cancels the upload' do
        expect(upload).to have_state(:canceled)
      end
    end

    context 'when there is previous upload in uploading state' do
      let(:state) { 'uploading' }

      it 'cancels the upload' do
        expect(upload).to have_state(:canceled)
      end
    end

    context 'when there is previous upload in published state' do
      let(:state) { 'published' }

      it 'does not cancel the upload' do
        expect(upload).not_to have_state(:canceled)
      end
    end
  end

  describe '#copy_files_to_current_data' do
    let(:new_upload) { build(:supply_teachers_admin_upload) }

    before { new_upload.pricing_for_tool = valid_xlsx_file_path }

    context 'when a CurrentData object does not exist' do
      before { SupplyTeachers::Admin::CurrentData.first&.delete }

      it 'creates a CurrentData object' do
        expect { new_upload.save }.to change(SupplyTeachers::Admin::CurrentData, :count).by(1)
      end

      it 'updates all CurrentData files to match the Upload object' do
        new_upload.save

        expect(SupplyTeachers::Admin::CurrentData.first.pricing_for_tool.blob).to eq new_upload.pricing_for_tool.blob
      end
    end

    context 'when a CurrentData object exists' do
      before { upload }

      it 'does not create a new CurrentData object' do
        expect { new_upload.save }.not_to change(SupplyTeachers::Admin::CurrentData, :count)
      end

      it 'updates the existing CurrentData object' do
        new_upload.save

        expect(SupplyTeachers::Admin::CurrentData.first.pricing_for_tool.blob).not_to eq upload.pricing_for_tool.blob
        expect(SupplyTeachers::Admin::CurrentData.first.pricing_for_tool.blob).to eq new_upload.pricing_for_tool.blob
      end
    end
  end
end
