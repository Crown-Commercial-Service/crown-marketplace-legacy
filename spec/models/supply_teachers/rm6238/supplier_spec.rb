require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Supplier, type: :model do
  subject(:supplier) { build(:supply_teachers_rm6238_supplier) }

  describe 'validations' do
    before { supplier.name = supplier_name }

    context 'when the supplier name is blank' do
      let(:supplier_name) { '' }

      it 'is not valid' do
        expect(supplier).not_to be_valid
      end
    end

    context 'when the supplier name is present' do
      let(:supplier_name) { supplier.name }

      it 'is valid' do
        expect(supplier).to be_valid
      end
    end
  end

  context 'when destroying the supplier' do
    before { supplier.save! }

    context 'and the supplier has branches' do
      let!(:first_branch) { create(:supply_teachers_rm6238_branch, supplier: supplier) }
      let!(:second_branch) { create(:supply_teachers_rm6238_branch, supplier: supplier) }

      it 'destroys all its branches' do
        supplier.destroy!

        expect(SupplyTeachers::RM6238::Branch.exists?(first_branch.id)).to be false
        expect(SupplyTeachers::RM6238::Branch.exists?(second_branch.id)).to be false
      end
    end

    context 'and the supplier has rates' do
      let!(:rate) { create(:supply_teachers_rm6238_rate, supplier: supplier) }

      it 'destroys all its rates' do
        supplier.destroy!

        expect(SupplyTeachers::RM6238::Rate.exists?(rate.id)).to be false
      end
    end

    context 'and the supplier has manged service providers' do
      let!(:managed_service_provider_1) { create(:supply_teachers_rm6238_managed_service_provider_master_vendor, supplier: supplier) }
      let!(:managed_service_provider_2) { create(:supply_teachers_rm6238_managed_service_provider_master_vendor, supplier: supplier) }

      it 'destroys all its rates' do
        supplier.destroy!

        expect(SupplyTeachers::RM6238::ManagedServiceProvider.exists?(managed_service_provider_1.id)).to be false
        expect(SupplyTeachers::RM6238::ManagedServiceProvider.exists?(managed_service_provider_2.id)).to be false
      end
    end
  end

  describe '#nominated_worker_rate' do
    before { create(rate, supplier: supplier, job_type: 'nominated', rate: 1250) if rate }

    context 'and there is a nomintaed worker rate' do
      let(:rate) { :supply_teachers_rm6238_rate }

      it 'returns the rate' do
        expect(supplier.nominated_worker_rate).to eq(12.5)
      end
    end

    context 'and there is not a nomintaed worker rate' do
      let(:rate) { :supply_teachers_rm6238_master_vendor_above_threshold_rate }

      it 'returns nil' do
        expect(supplier.nominated_worker_rate).to be_nil
      end
    end

    context 'and there is no rate' do
      let(:rate) { nil }

      it 'returns nil' do
        expect(supplier.nominated_worker_rate).to be_nil
      end
    end
  end

  describe '#fixed_term_rate' do
    before { create(rate, supplier: supplier, job_type: 'fixed_term', rate: 1250) if rate }

    context 'and there is a nomintaed worker rate' do
      let(:rate) { :supply_teachers_rm6238_rate }

      it 'returns the rate' do
        expect(supplier.fixed_term_rate).to eq(12.5)
      end
    end

    context 'and there is not a nomintaed worker rate' do
      let(:rate) { :supply_teachers_rm6238_master_vendor_above_threshold_rate }

      it 'returns nil' do
        expect(supplier.fixed_term_rate).to be_nil
      end
    end

    context 'and there is no rate' do
      let(:rate) { nil }

      it 'returns nil' do
        expect(supplier.fixed_term_rate).to be_nil
      end
    end
  end

  describe 'with managed service provider rates' do
    let!(:supplier_with_direct_provision_rate) do
      create(:supply_teachers_rm6238_supplier).tap do |supplier|
        create(:rm6238_direct_provision_rate, supplier: supplier)
      end
    end

    let(:suppliers) { described_class.with_master_vendor_rates(threshold_position) }

    context 'when calling with_master_vendor_rates with below_threshold' do
      let!(:supplier_with_master_vendor_below_threshold_rate) do
        create(:supply_teachers_rm6238_supplier).tap do |supplier|
          create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, supplier: supplier)
        end
      end

      let(:threshold_position) { :below_threshold }

      it 'returns suppliers with master vendor rates' do
        expect(suppliers).to include(supplier_with_master_vendor_below_threshold_rate)
      end

      it 'does not return suppliers with direct provision rates' do
        expect(suppliers).not_to include(supplier_with_direct_provision_rate)
      end
    end

    context 'when calling with_master_vendor_rates with above_threshold' do
      let!(:supplier_with_master_vendor_above_threshold_rate) do
        create(:supply_teachers_rm6238_supplier).tap do |supplier|
          create(:supply_teachers_rm6238_master_vendor_above_threshold_rate, supplier: supplier)
        end
      end

      let(:threshold_position) { :above_threshold }

      it 'returns suppliers with master vendor rates' do
        expect(suppliers).to include(supplier_with_master_vendor_above_threshold_rate)
      end

      it 'does not return suppliers with direct provision rates' do
        expect(suppliers).not_to include(supplier_with_direct_provision_rate)
      end
    end

    context 'when calling with_education_technology_platforms_rates' do
      let!(:supplier_with_education_technology_platforms_rate) do
        create(:supply_teachers_rm6238_supplier).tap do |supplier|
          create(:supply_teachers_rm6238_education_technology_platforms_rate, supplier: supplier)
        end
      end

      let(:suppliers) { described_class.with_education_technology_platforms_rates }

      it 'returns suppliers with master vendor rates' do
        expect(suppliers).to include(supplier_with_education_technology_platforms_rate)
      end

      it 'does not return suppliers with direct provision rates' do
        expect(suppliers).not_to include(supplier_with_direct_provision_rate)
      end
    end
  end

  describe 'with managed service provider rates grouped by job type' do
    let!(:rate_teacher_daily) do
      create(managed_service_provider, supplier: supplier, job_type: 'teacher', term: 'daily')
    end
    let!(:rate_teacher_six_weeks_plus) do
      create(managed_service_provider, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus')
    end

    let!(:rate_senior_daily) do
      create(managed_service_provider, supplier: supplier, job_type: 'senior', term: 'daily')
    end
    let!(:rate_senior_six_weeks_plus) do
      create(managed_service_provider, supplier: supplier, job_type: 'senior', term: 'six_weeks_plus')
    end

    let(:job_types_vs_rates) { supplier.master_vendor_rates_grouped_by_job_type(threshold_position) }

    context 'when calling master_vendor_rates_grouped_by_job_type with below_threshold' do
      let(:threshold_position) { :below_threshold }
      let(:managed_service_provider) { :supply_teachers_rm6238_master_vendor_below_threshold_rate }

      it 'returns rates grouped by job type' do
        expect(job_types_vs_rates['teacher']).to include(
          rate_teacher_daily,
          rate_teacher_six_weeks_plus
        )
        expect(job_types_vs_rates['senior']).to include(
          rate_senior_daily,
          rate_senior_six_weeks_plus
        )
      end
    end

    context 'when calling master_vendor_rates_grouped_by_job_type with above_threshold' do
      let(:threshold_position) { :above_threshold }
      let(:managed_service_provider) { :supply_teachers_rm6238_master_vendor_above_threshold_rate }

      it 'returns rates grouped by job type' do
        expect(job_types_vs_rates['teacher']).to include(
          rate_teacher_daily,
          rate_teacher_six_weeks_plus
        )
        expect(job_types_vs_rates['senior']).to include(
          rate_senior_daily,
          rate_senior_six_weeks_plus
        )
      end
    end

    context 'when calling education_technology_platforms_rates_grouped_by_job_type' do
      let(:managed_service_provider) { :supply_teachers_rm6238_education_technology_platforms_rate }
      let(:job_types_vs_rates) { supplier.education_technology_platforms_rates_grouped_by_job_type }

      it 'returns rates grouped by job type' do
        expect(job_types_vs_rates['teacher']).to include(
          rate_teacher_daily,
          rate_teacher_six_weeks_plus
        )
        expect(job_types_vs_rates['senior']).to include(
          rate_senior_daily,
          rate_senior_six_weeks_plus
        )
      end
    end
  end

  describe '.rates_grouped_by_job_type' do
    let(:supplier) { create(:supply_teachers_rm6238_supplier) }
    let!(:rate_teacher_1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'daily') }
    let!(:rate_teacher_2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus') }
    let!(:rate_support_1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'support', term: 'daily') }
    let!(:rate_support_2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'support', term: 'six_weeks_plus') }
    let!(:rate_nominated) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'nominated') }

    let(:lot_1_grouped_rates) do
      {
        'teacher' => [rate_teacher_1, rate_teacher_2],
        'support' => [rate_support_1, rate_support_2],
        'nominated' => [rate_nominated]
      }
    end

    before do
      create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, supplier: supplier, job_type: 'teacher', term: 'daily')
      create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus')
      create(:supply_teachers_rm6238_education_technology_platforms_rate, supplier: supplier, job_type: 'agency_management', term: 'daily')
    end

    it 'returns only the rates in lot 1 gouped by job' do
      expect(supplier.rates_grouped_by_job_type).to eq(lot_1_grouped_rates)
    end
  end

  describe '.rate_for' do
    let(:rate) { supplier.rate_for(job_type: SupplyTeachers::RM6238::JobType.find_role_by(code: job_type), term: SupplyTeachers::RM6238::Term.find_by(code: term)) }

    before do
      create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'daily', rate: 1234)
      create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus', rate: 2345)
      create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'senior', term: 'daily', rate: 3456)
      create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'senior', term: 'six_weeks_plus', rate: 4567)
      create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, supplier: supplier, job_type: 'senior', term: 'daily', rate: 5678)
    end

    context 'when the job_type is teacher' do
      let(:job_type) { 'teacher' }

      context 'and the term is daily' do
        let(:term) { 'daily' }

        it 'returns the correct rate' do
          expect(rate).to eq 12.34
        end
      end

      context 'and the term is six_weeks_plus' do
        let(:term) { 'six_weeks_plus' }

        it 'returns the correct rate' do
          expect(rate).to eq 23.45
        end
      end

      context 'and the term is not in the list' do
        let(:term) { '12_weeks' }

        it 'returns nil' do
          expect(rate).to be_nil
        end
      end
    end

    context 'when the job_type is senior' do
      let(:job_type) { 'senior' }

      context 'and the term is daily' do
        let(:term) { 'daily' }

        it 'returns the correct rate' do
          expect(rate).to eq 34.56
        end
      end

      context 'and the term is six_weeks_plus' do
        let(:term) { 'six_weeks_plus' }

        it 'returns the correct rate' do
          expect(rate).to eq 45.67
        end
      end

      context 'and the term is not in the list' do
        let(:term) { '12_weeks' }

        it 'returns nil' do
          expect(rate).to be_nil
        end
      end
    end

    context 'when the job_type is not in the list' do
      let(:job_type) { 'qt' }

      context 'and the term is daily' do
        let(:term) { 'daily' }

        it 'returns nil' do
          expect(rate).to be_nil
        end
      end

      context 'and the term is six_weeks_plus' do
        let(:term) { 'six_weeks_plus' }

        it 'returns nil' do
          expect(rate).to be_nil
        end
      end

      context 'and the term is not in the list' do
        let(:term) { '12_weeks' }

        it 'returns nil' do
          expect(rate).to be_nil
        end
      end
    end
  end
end
