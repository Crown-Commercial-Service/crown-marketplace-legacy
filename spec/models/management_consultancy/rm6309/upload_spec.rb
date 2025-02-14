require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::Upload do
  describe 'create' do
    let(:supplier_name) { Faker::Name.unique.name }
    let(:supplier_id) { SecureRandom.uuid }
    let(:contact_email) { Faker::Internet.unique.email }
    let(:telephone_number) { Faker::PhoneNumber.unique.phone_number }

    let(:lots) { [] }

    let(:suppliers) do
      [
        {
          'name' => supplier_name,
          'supplier_id' => supplier_id,
          'contact_email' => contact_email,
          'telephone_number' => telephone_number,
          'lots' => lots
        }
      ]
    end

    context 'when supplier list is empty' do
      let(:suppliers) { [] }

      it 'does not create any suppliers' do
        expect do
          described_class.upload!(suppliers)
        end.not_to change(ManagementConsultancy::RM6309::Supplier, :count)
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
        end.to change(ManagementConsultancy::RM6309::Supplier, :count).by(1)
      end

      it 'assigns ID to supplier' do
        described_class.upload!(suppliers)

        supplier = ManagementConsultancy::RM6309::Supplier.last
        expect(supplier.id).to eq(supplier_id)
      end

      it 'assigns attributes to supplier' do
        described_class.upload!(suppliers)

        supplier = ManagementConsultancy::RM6309::Supplier.last
        expect(supplier.name).to eq(supplier_name)
      end

      it 'assigns contact-related attributes to supplier' do
        described_class.upload!(suppliers)

        supplier = ManagementConsultancy::RM6309::Supplier.last
        expect(supplier.contact_email).to eq(contact_email)
        expect(supplier.telephone_number).to eq(telephone_number)
      end

      context 'and supplier has lots with services' do
        let(:lots) do
          [
            {
              'lot_number' => 'MCF4.1',
              'services' => %w[MCF4.1.1 MCF4.1.2]
            },
            {
              'lot_number' => 'MCF4.2',
              'services' => %w[MCF4.2.1]
            },
          ]
        end

        let(:supplier) { ManagementConsultancy::RM6309::Supplier.last }

        let(:service_offerings) do
          supplier.service_offerings.order(:lot_number, :service_code)
        end

        it 'creates service offerings associated with supplier' do
          expect do
            described_class.upload!(suppliers)
          end.to change(ManagementConsultancy::RM6309::ServiceOffering, :count).by(3)
        end

        it 'assigns attributes to first service offering' do
          described_class.upload!(suppliers)

          offering = service_offerings.first
          expect(offering.lot_number).to eq('MCF4.1')
          expect(offering.service_code).to eq('MCF4.1.1')
        end

        it 'assigns attributes to second service offering' do
          described_class.upload!(suppliers)

          offering = service_offerings.second
          expect(offering.lot_number).to eq('MCF4.1')
          expect(offering.service_code).to eq('MCF4.1.2')
        end

        it 'assigns attributes to third service offering' do
          described_class.upload!(suppliers)

          offering = service_offerings.third
          expect(offering.lot_number).to eq('MCF4.2')
          expect(offering.service_code).to eq('MCF4.2.1')
        end
      end
    end

    context 'when suppliers already exist' do
      let!(:first_supplier) { create(:management_consultancy_rm6309_supplier) }
      let!(:second_supplier) { create(:management_consultancy_rm6309_supplier) }

      it 'destroys all existing suppliers' do
        described_class.upload!(suppliers)

        expect(ManagementConsultancy::RM6309::Supplier.find_by(id: first_supplier.id))
          .to be_nil
        expect(ManagementConsultancy::RM6309::Supplier.find_by(id: second_supplier.id))
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

          expect(ManagementConsultancy::RM6309::Supplier.find_by(id: first_supplier.id))
            .to eq(first_supplier)
          expect(ManagementConsultancy::RM6309::Supplier.find_by(id: second_supplier.id))
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
        end.not_to change(ManagementConsultancy::RM6309::Supplier, :count)
      end
    end

    context 'when data for one lot is invalid' do
      let(:lots) do
        [
          {
            'lot_number' => 'MCF4.1',
            'services' => %w[MCF4.1.1 MCF4.1.2]
          },
          {
            'lot_number' => '',
            'services' => %w[MCF4.2.1]
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
        end.not_to change(ManagementConsultancy::RM6309::Supplier, :count)
      end
    end

    context 'when data for one service is invalid' do
      let(:lots) do
        [
          {
            'lot_number' => 'MCF4.1',
            'services' => %w[MCF4.1.1 MCF4.1.2]
          },
          {
            'lot_number' => 'MCF4.2',
            'services' => ['']
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
        end.not_to change(ManagementConsultancy::RM6309::Supplier, :count)
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
