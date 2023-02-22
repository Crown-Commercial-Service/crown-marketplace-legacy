require 'rails_helper'

RSpec.describe SupplyTeachers::Admin::UploadsHelper do
  describe 'upload_status_tag' do
    let(:status_tag) { helper.upload_status_tag(status) }

    context 'when the status is not_started' do
      let(:status) { 'not_started' }

      it 'returns in Not started and grey' do
        expect(status_tag).to eq ['Not started', :grey]
      end
    end

    context 'when the status is processing_files' do
      let(:status) { 'processing_files' }

      it 'returns in Processing files and grey' do
        expect(status_tag).to eq ['Processing files', :grey]
      end
    end

    context 'when the status is files_processed' do
      let(:status) { 'files_processed' }

      it 'returns in Waiting to publish and nil' do
        expect(status_tag).to eq ['Waiting to publish', nil]
      end
    end

    context 'when the status is rejected' do
      let(:status) { 'rejected' }

      it 'returns in Cancelled session and red' do
        expect(status_tag).to eq ['Cancelled session', :red]
      end
    end

    context 'when the status is canceled' do
      let(:status) { 'canceled' }

      it 'returns in Cancelled session and red' do
        expect(status_tag).to eq ['Cancelled session', :red]
      end
    end

    context 'when the status is uploading' do
      let(:status) { 'uploading' }

      it 'returns in Publishing files and grey' do
        expect(status_tag).to eq ['Publishing files', :grey]
      end
    end

    context 'when the status is published' do
      let(:status) { 'published' }

      it 'returns Published on live and nil' do
        expect(status_tag).to eq ['Published on live', nil]
      end
    end

    context 'when the status is failed' do
      let(:status) { 'failed' }

      it 'returns Failed and red' do
        expect(status_tag).to eq ['Failed', :red]
      end
    end
  end
end
