require 'rails_helper'

RSpec.describe ApplicationController do
  describe '.service_path_base' do
    before do
      controller.params[:service] = service if service
      controller.params[:framework] = framework if framework
    end

    let(:result) { controller.send(:service_path_base) }
    let(:service) { nil }
    let(:framework) { nil }

    context 'when the service is nil' do
      context 'when the framework is nil' do
        it 'returns /supply-teachers/RM6238' do
          expect(result).to eq '/supply-teachers/RM6238'
        end
      end

      context 'when the framework is present' do
        let(:framework) { 'RM007' }

        it 'returns /supply-teachers/RM007' do
          expect(result).to eq '/supply-teachers/RM007'
        end
      end
    end

    context 'when the service is supply teachers' do
      let(:service) { 'supply_teachers' }

      context 'when the framework is nil' do
        it 'returns /supply-teachers/RM6238' do
          expect(result).to eq '/supply-teachers/RM6238'
        end
      end

      context 'when the framework is present' do
        let(:framework) { 'RM3826' }

        it 'returns /supply-teachers/RM3826' do
          expect(result).to eq '/supply-teachers/RM3826'
        end
      end
    end

    context 'when the service is supply teachers admin' do
      let(:service) { 'supply_teachers/admin' }

      context 'when the framework is nil' do
        it 'returns /supply-teachers/RM6238/admin' do
          expect(result).to eq '/supply-teachers/RM6238/admin'
        end
      end

      context 'when the framework is present' do
        let(:framework) { 'RM3826' }

        it 'returns /supply-teachers/RM3826/admin' do
          expect(result).to eq '/supply-teachers/RM3826/admin'
        end
      end
    end

    context 'when the service is management consultancy' do
      let(:service) { 'management_consultancy' }

      context 'when the framework is nil' do
        it 'returns /management-consultancy/RM6309' do
          expect(result).to eq '/management-consultancy/RM6309'
        end
      end

      context 'when the framework is present and the framework is RM6187' do
        let(:framework) { 'RM6187' }

        it 'returns /management-consultancy/RM6187' do
          expect(result).to eq '/management-consultancy/RM6187'
        end
      end

      context 'when the framework is present and the framework is RM6309' do
        let(:framework) { 'RM6309' }

        it 'returns /management-consultancy/RM6309' do
          expect(result).to eq '/management-consultancy/RM6309'
        end
      end
    end

    context 'when the service is management consultancy admin' do
      let(:service) { 'management_consultancy/admin' }

      context 'when the framework is nil' do
        it 'returns /management-consultancy/RM6309/admin' do
          expect(result).to eq '/management-consultancy/RM6309/admin'
        end
      end

      context 'when the framework is present and the framework is RM6187' do
        let(:framework) { 'RM6187' }

        it 'returns /management-consultancy/RM6187/admin' do
          expect(result).to eq '/management-consultancy/RM6187/admin'
        end
      end

      context 'when the framework is present and the framework is RM6309' do
        let(:framework) { 'RM6309' }

        it 'returns /management-consultancy/RM6309/admin' do
          expect(result).to eq '/management-consultancy/RM6309/admin'
        end
      end
    end

    context 'when the service is legal services' do
      let(:service) { 'legal_services' }

      context 'when the framework is nil' do
        it 'returns /legal-services/RM6240' do
          expect(result).to eq '/legal-services/RM6240'
        end
      end

      context 'when the framework is present' do
        let(:framework) { 'RM3788' }

        it 'returns /legal-services/RM3788' do
          expect(result).to eq '/legal-services/RM3788'
        end
      end
    end

    context 'when the service is legal services admin' do
      let(:service) { 'legal_services/admin' }

      context 'when the framework is nil' do
        it 'returns /legal-services/RM6240/admin' do
          expect(result).to eq '/legal-services/RM6240/admin'
        end
      end

      context 'when the framework is present' do
        let(:framework) { 'RM3788' }

        it 'returns /legal-services/RM3788/admin' do
          expect(result).to eq '/legal-services/RM3788/admin'
        end
      end
    end
  end
end
