require 'rails_helper'

RSpec.describe LegalServices::RM6240::Upload do
  describe 'create' do
    let(:supplier_name) { Faker::Name.unique.name }
    let(:supplier_id) { SecureRandom.uuid }
    let(:contact_email) { Faker::Internet.unique.email }
    let(:telephone_number) { Faker::PhoneNumber.unique.phone_number }

    let(:service_offerings) { [] }
    let(:rates) { [] }

    let(:suppliers) do
      [
        {
          'name' => supplier_name,
          'supplier_id' => supplier_id,
          'email' => contact_email,
          'phone_number' => telephone_number,
          'service_offerings' => service_offerings,
          'rates' => rates,
        }
      ]
    end

    context 'when supplier list is empty' do
      let(:suppliers) { [] }

      it 'does not create any suppliers' do
        expect do
          described_class.upload!(suppliers)
        end.not_to change(LegalServices::RM6240::Supplier, :count)
      end
    end

    context 'when supplier does not exist' do
      it 'creates record of successful upload' do
        expect do
          described_class.upload!(suppliers)
        end.to change(described_class, :count).by(1)
      end

      it 'creates supplier' do
        expect do
          described_class.upload!(suppliers)
        end.to change(LegalServices::RM6240::Supplier, :count).by(1)
      end

      it 'assigns ID to supplier' do
        described_class.upload!(suppliers)

        supplier = LegalServices::RM6240::Supplier.last
        expect(supplier.id).to eq(supplier_id)
      end

      it 'assigns attributes to supplier' do
        described_class.upload!(suppliers)

        supplier = LegalServices::RM6240::Supplier.last
        expect(supplier.name).to eq(supplier_name)
      end

      it 'assigns contact-related attributes to supplier' do
        described_class.upload!(suppliers)

        supplier = LegalServices::RM6240::Supplier.last
        expect(supplier.email).to eq(contact_email)
        expect(supplier.phone_number).to eq(telephone_number)
      end

      context 'and supplier is offering lot 1 services' do
        let(:service_offerings) do
          [
            {
              'service_code' => '1.1',
              'jurisdiction' => 'a'
            },
            {
              'service_code' => '1.2',
              'jurisdiction' => 'a'
            },
            {
              'service_code' => '1.1',
              'jurisdiction' => 'b'
            },
          ]
        end

        let(:supplier) { LegalServices::RM6240::Supplier.last }

        let(:supplier_service_offerings) do
          supplier.service_offerings.order(:jurisdiction)
        end

        it 'creates service offerings associated with supplier' do
          expect do
            described_class.upload!(suppliers)
          end.to change(LegalServices::RM6240::ServiceOffering, :count).by(3)
        end

        it 'assigns attributes to the service offerings' do
          described_class.upload!(suppliers)

          availability = supplier_service_offerings.map { |supplier_service_offering| supplier_service_offering.attributes.slice('service_code', 'jurisdiction') }

          expect(availability).to eq(service_offerings)
        end
      end

      context 'and supplier has rates' do
        let(:rates) do
          [
            {
              'lot_number' => '2',
              'jurisdiction' => 'a',
              'position' => '1',
              'rate' => 10000
            },
            {
              'lot_number' => '3',
              'jurisdiction' => nil,
              'position' => '1',
              'rate' => 20000
            },
          ]
        end

        let(:supplier) { LegalServices::RM6240::Supplier.last }

        let(:supplier_rates) do
          supplier.rates.order(:lot_number)
        end

        it 'creates rates associated with supplier' do
          expect do
            described_class.upload!(suppliers)
          end.to change(LegalServices::RM6240::Rate, :count).by(2)
        end

        it 'assigns attributes to the rates' do
          described_class.upload!(suppliers)

          offering = supplier_rates.map { |supplier_rate| supplier_rate.attributes.slice('lot_number', 'jurisdiction', 'position', 'rate') }

          expect(offering).to eq(rates)
        end
      end
    end

    context 'when suppliers already exist' do
      let!(:first_supplier) { create(:legal_services_rm6240_supplier) }
      let!(:second_supplier) { create(:legal_services_rm6240_supplier) }

      it 'destroys all existing suppliers' do
        described_class.upload!(suppliers)

        expect(LegalServices::RM6240::Supplier.find_by(id: first_supplier.id))
          .to be_nil
        expect(LegalServices::RM6240::Supplier.find_by(id: second_supplier.id))
          .to be_nil
      end

      context 'and data for one supplier is invalid' do
        let(:suppliers) do
          [
            {
              'supplier_name' => ''
            }
          ]
        end

        it 'does not create record of unsuccessful upload' do
          expect do
            ignoring_exception(ActiveRecord::RecordInvalid) do
              described_class.upload!(suppliers)
            end
          end.not_to change(described_class, :count)
        end

        it 'leaves existing data intact' do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end

          expect(LegalServices::RM6240::Supplier.find_by(id: first_supplier.id))
            .to eq(first_supplier)
          expect(LegalServices::RM6240::Supplier.find_by(id: second_supplier.id))
            .to eq(second_supplier)
        end
      end
    end

    context 'when data for one supplier is invalid' do
      let(:suppliers) do
        [
          {
            'supplier_name' => supplier_name,
          },
          {
            'supplier_name' => '',
          }
        ]
      end

      it 'raises ActiveRecord::RecordInvalid exception' do
        expect do
          described_class.upload!(suppliers)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not create any suppliers' do
        expect do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end
        end.not_to change(LegalServices::RM6240::Supplier, :count)
      end
    end

    context 'when data for one service is invalid' do
      let(:service_offerings) do
        [
          {
            'service_code' => 'invalid',
            'jurisdiction' => 'a'
          },
          {
            'service_code' => '1.2',
            'jurisdiction' => 'a'
          },
          {
            'service_code' => '1.1',
            'jurisdiction' => 'b'
          },
        ]
      end

      it 'raises ActiveRecord::RecordInvalid exception' do
        expect do
          described_class.upload!(suppliers)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not create any suppliers' do
        expect do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end
        end.not_to change(LegalServices::RM6240::Supplier, :count)
      end
    end

    context 'when data for one rate is invalid' do
      let(:rates) do
        [
          {
            'lot_number' => '2',
            'jurisdiction' => 'a',
            'position' => '1'
          },
          {
            'lot_number' => '3',
            'jurisdiction' => nil,
            'position' => '1',
            'rate' => 20000
          },
        ]
      end

      it 'raises ActiveRecord::RecordInvalid exception' do
        expect do
          described_class.upload!(suppliers)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not create any suppliers' do
        expect do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end
        end.not_to change(LegalServices::RM6240::Supplier, :count)
      end
    end
  end

  private

  def ignoring_exception(exception)
    yield
  rescue exception
    nil
  end
end
