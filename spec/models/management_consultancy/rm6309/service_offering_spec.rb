require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::ServiceOffering do
  subject(:service_offering) { build(:management_consultancy_rm6309_service_offering) }

  it { is_expected.to be_valid }

  it 'is not valid if lot_number is blank' do
    service_offering.lot_number = ''
    expect(service_offering).not_to be_valid
  end

  it 'is not valid if lot_number is not in list of all lot numbers' do
    service_offering.lot_number = 'invalid-number'
    expect(service_offering).not_to be_valid
    expect(service_offering.errors[:lot_number]).to include('is not included in the list')
  end

  it 'is not valid if offering exists for same lot_number, service_code & supplier' do
    service_offering.save!
    new_offering = build(
      :management_consultancy_rm6309_service_offering,
      supplier: service_offering.supplier,
      lot_number: service_offering.lot_number,
      service_code: service_offering.service_code
    )
    expect(new_offering).not_to be_valid
    expect(new_offering.errors[:lot_number]).to include('has already been taken')
    expect(new_offering.errors[:service_code]).to include('has already been taken')
  end

  it 'is valid even if offering exists for same lot_number & service_code, but different supplier' do
    service_offering.save!
    new_offering = build(
      :management_consultancy_rm6309_service_offering,
      supplier: build(:management_consultancy_rm6309_supplier),
      lot_number: service_offering.lot_number,
      service_code: service_offering.service_code
    )
    expect(new_offering).to be_valid
  end

  it 'is valid even if offering exists for same service_code & supplier, but different lot_number' do
    service_offering.save!
    new_offering = build(
      :management_consultancy_rm6309_service_offering,
      supplier: service_offering.supplier,
      lot_number: 'MCF4.1',
      service_code: service_offering.service_code
    )
    expect(new_offering).to be_valid
  end

  it 'is valid even if offering exists for same lot_number & supplier, but different service_code' do
    service_offering.save!
    new_offering = build(
      :management_consultancy_rm6309_service_offering,
      supplier: service_offering.supplier,
      lot_number: service_offering.lot_number,
      service_code: 'MCF4.2.2'
    )
    expect(new_offering).to be_valid
  end

  it 'is not valid if service_code is blank' do
    service_offering.service_code = ''
    expect(service_offering).not_to be_valid
  end

  it 'is not valid if service_code is not in list of all service codes' do
    service_offering.service_code = 'invalid-code'
    expect(service_offering).not_to be_valid
    expect(service_offering.errors[:service_code]).to include('is not included in the list')
  end

  it 'can be associated with one management consultancy supplier' do
    supplier = build(:management_consultancy_rm6309_supplier)
    offering = supplier.service_offerings.build
    expect(offering.supplier).to eq(supplier)
  end

  it 'looks up service based on its code' do
    offering = build(:management_consultancy_rm6309_service_offering, service_code: 'MCF4.3.3')
    expect(offering.service).to be_instance_of(ManagementConsultancy::RM6309::Service)
    expect(offering.service.code).to eq('MCF4.3.3')
  end
end
