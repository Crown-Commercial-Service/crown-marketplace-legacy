require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Admin::Upload do
  let(:blank_upload) { build(:supply_teachers_rm6238_admin_upload) }
  let(:upload) do
    admin_upload = build(:supply_teachers_rm6238_admin_upload)
    admin_upload.update(current_accredited_suppliers: create_file(*FILE_PARAMS[:valid_xlsx]))
    admin_upload.update(pricing_for_tool: create_file(*FILE_PARAMS[:valid_xlsx]))
    admin_upload
  end
  let(:created_files) { [] }

  def create_file(extension, content)
    temp_file = Tempfile.new(['supplier_data', ".#{extension}"])
    created_files << temp_file

    fixture_file_upload(temp_file.path, content)
  end

  after { created_files.each(&:unlink) }

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
          blank_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:invalid_xlsx_file_extension])
          blank_upload.geographical_data_all_suppliers = create_file(*FILE_PARAMS[:invalid_xlsx_file_extension])
          blank_upload.master_vendor_contacts = create_file(*FILE_PARAMS[:invalid_csv_file_extension])
          blank_upload.education_technology_platform_contacts = create_file(*FILE_PARAMS[:invalid_csv_file_extension])
          blank_upload.pricing_for_tool = create_file(*FILE_PARAMS[:invalid_xlsx_file_extension])
          blank_upload.supplier_lookup = create_file(*FILE_PARAMS[:invalid_csv_file_extension])
        end

        it 'is not valid and has the correct error messages' do
          expect(blank_upload.save).to be false
          expect(blank_upload.errors.messages.values.flatten).to match ["The 'Current accredited suppliers' file must be an XLSX", "The 'Geographical data all suppliers' file must be an XLSX", "The 'Master vendor contacts' file must be a CSV", "The 'Education technology platform contacts' file must be a CSV", "The 'Pricing for tool' file must be an XLSX", "The 'Supplier lookup' file must be a CSV"]
        end
      end
    end

    context 'when considering the file content type' do
      context 'and no files have the correct content type' do
        before do
          blank_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:invalid_xlsx_file_content])
          blank_upload.geographical_data_all_suppliers = create_file(*FILE_PARAMS[:invalid_xlsx_file_content])
          blank_upload.master_vendor_contacts = create_file(*FILE_PARAMS[:invalid_csv_file_content])
          blank_upload.education_technology_platform_contacts = create_file(*FILE_PARAMS[:invalid_csv_file_content])
          blank_upload.pricing_for_tool = create_file(*FILE_PARAMS[:invalid_xlsx_file_content])
          blank_upload.supplier_lookup = create_file(*FILE_PARAMS[:invalid_csv_file_content])
        end

        it 'is not valid and has the correct error messages' do
          expect(blank_upload.save).to be false
          expect(blank_upload.errors.messages.values.flatten).to match ["The 'Current accredited suppliers' file does not contain the expected content type", "The 'Geographical data all suppliers' file does not contain the expected content type", "The 'Master vendor contacts' file does not contain the expected content type", "The 'Pricing for tool' file does not contain the expected content type", "The 'Supplier lookup' file does not contain the expected content type", "The 'Education technology platform contacts' file does not contain the expected content type"]
        end
      end
    end

    context 'when all uploaded files are valid' do
      context 'and two files are attached' do
        before do
          blank_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:valid_xlsx])
          blank_upload.supplier_lookup = create_file(*FILE_PARAMS[:valid_csv])
        end

        it 'is valid' do
          expect(upload.save).to be true
        end
      end

      context 'and all 7 files are attached' do
        before do
          blank_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:valid_xlsx])
          blank_upload.geographical_data_all_suppliers = create_file(*FILE_PARAMS[:valid_xlsx])
          blank_upload.master_vendor_contacts = create_file(*FILE_PARAMS[:valid_csv])
          blank_upload.education_technology_platform_contacts = create_file(*FILE_PARAMS[:valid_csv])
          blank_upload.pricing_for_tool = create_file(*FILE_PARAMS[:valid_xlsx])
          blank_upload.supplier_lookup = create_file(*FILE_PARAMS[:valid_csv])
        end

        it 'is valid' do
          expect(upload.save).to be true
        end
      end
    end
  end

  describe '#default scope' do
    it 'orders by descending created_at' do
      expect(described_class.all.to_sql).to eq described_class.order(created_at: :desc).to_sql
    end
  end

  describe '#aasm state' do
    it 'starts at not_started state' do
      expect(upload).to have_state(:not_started)
    end

    context 'when start_upload is called' do
      before do
        allow(SupplyTeachers::RM6238::Admin::DataImportWorker).to receive(:perform_async).with(upload.id).and_return(true)
        upload.start_upload!
      end

      it 'changes the state to processing_files' do
        expect(upload).to have_state(:processing_files)
      end

      it 'starts the worker' do
        expect(SupplyTeachers::RM6238::Admin::DataImportWorker).to have_received(:perform_async).with(upload.id)
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
        allow(SupplyTeachers::RM6238::Admin::DataUploadWorker).to receive(:perform_async).with(upload.id).and_return(true)
        upload.approve!
      end

      it 'changes the state to uploading' do
        expect(upload).to have_state(:uploading)
      end

      it 'starts the worker' do
        expect(SupplyTeachers::RM6238::Admin::DataUploadWorker).to have_received(:perform_async).with(upload.id)
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
    let(:new_upload) { build(:supply_teachers_rm6238_admin_upload) }

    context 'when no previous upload exists' do
      it 'returns false for current_accredited_suppliers' do
        expect(new_upload.send(:available_for_cp, nil, :current_accredited_suppliers)).to be false
      end

      it 'returns false for pricing_for_tool' do
        expect(new_upload.send(:available_for_cp, nil, :pricing_for_tool)).to be false
      end
    end

    context 'when previous approved upload exists' do
      before do
        new_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:valid_xlsx])
        new_upload.pricing_for_tool = create_file(*FILE_PARAMS[:valid_xlsx])
        upload.update!(aasm_state: 'published')
      end

      it 'returns true for current_accredited_suppliers' do
        expect(new_upload.send(:available_for_cp, upload.current_accredited_suppliers, :current_accredited_suppliers)).to be true
      end

      it 'returns false for geographical_data_all_suppliers' do
        expect(new_upload.send(:available_for_cp, upload.geographical_data_all_suppliers, :geographical_data_all_suppliers)).to be false
      end

      it 'returns false for master_vendor_contacts' do
        expect(new_upload.send(:available_for_cp, upload.master_vendor_contacts, :master_vendor_contacts)).to be false
      end

      it 'returns false for education_technology_platform_contacts' do
        expect(new_upload.send(:available_for_cp, upload.education_technology_platform_contacts, :education_technology_platform_contacts)).to be false
      end

      it 'returns true for pricing_for_tool' do
        expect(new_upload.send(:available_for_cp, upload.pricing_for_tool, :pricing_for_tool)).to be true
      end

      it 'returns false for supplier_lookup' do
        expect(new_upload.send(:available_for_cp, upload.supplier_lookup, :supplier_lookup)).to be false
      end
    end
  end

  describe '#files_count' do
    context 'when one file' do
      before do
        blank_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:valid_xlsx])
        blank_upload.save
      end

      it 'returns 1' do
        expect(blank_upload.files_count).to eq(1)
      end
    end
  end

  describe '#previous_uploaded_file_upload' do
    context 'when there is a previous approved upload' do
      before { upload.update!(aasm_state: 'published') }

      it 'returns previous approved object with uploaded file' do
        expect(described_class.previous_uploaded_file_upload(:current_accredited_suppliers)).to eq upload
        expect(described_class.previous_uploaded_file_upload(:pricing_for_tool)).to eq upload
      end

      it 'returns nil if file is not there' do
        expect(described_class.previous_uploaded_file_upload(:master_vendor_contacts)).to be_nil
      end
    end

    context 'when there is no previous upload that is approved' do
      it 'returns nil' do
        expect(described_class.previous_uploaded_file_upload(:pricing_for_tool)).to be_nil
      end
    end
  end

  describe '#reject_previous_uploads' do
    before do
      upload.update(aasm_state: state)
      new_upload = build(:supply_teachers_rm6238_admin_upload)
      new_upload.current_accredited_suppliers = create_file(*FILE_PARAMS[:valid_xlsx])
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
    let(:new_upload) do
      admin_upload = build(:supply_teachers_rm6238_admin_upload)
      admin_upload.update(pricing_for_tool: create_file(*FILE_PARAMS[:valid_xlsx]))
      admin_upload
    end

    context 'when a CurrentData object does not exist' do
      before { SupplyTeachers::RM6238::Admin::CurrentData.first&.delete }

      it 'creates a CurrentData object' do
        expect { new_upload }.to change(SupplyTeachers::RM6238::Admin::CurrentData, :count).by(1)
      end

      it 'updates all CurrentData files to match the Upload object' do
        new_upload

        expect(SupplyTeachers::RM6238::Admin::CurrentData.first.pricing_for_tool.blob).to eq new_upload.pricing_for_tool.blob
      end
    end

    context 'when a CurrentData object exists' do
      before { upload }

      it 'does not create a new CurrentData object' do
        expect { new_upload }.not_to change(SupplyTeachers::RM6238::Admin::CurrentData, :count)
      end

      it 'updates the existing CurrentData object' do
        new_upload

        expect(SupplyTeachers::RM6238::Admin::CurrentData.first.pricing_for_tool.blob).not_to eq upload.pricing_for_tool.blob
        expect(SupplyTeachers::RM6238::Admin::CurrentData.first.pricing_for_tool.blob).to eq new_upload.pricing_for_tool.blob
      end
    end
  end
end
