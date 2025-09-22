require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Spreadsheet do
  let(:telephone_number) { '0121 496 0123' }
  let(:branch1) { build(:supply_teachers_branch_search_result, telephone_number:) }
  let(:branch2) { build(:supply_teachers_branch_search_result, telephone_number: '029 2018 0999') }

  before do
    branch1.distance = 1600.0
    branch1.rate = create(:supplier_framework_lot_rate, rate: 10000, position_id: position_id)
    branch2.distance = 3200.0
    branch2.rate = create(:supplier_framework_lot_rate, rate: 20000, position_id: position_id)
  end

  context 'without fixed term results' do
    subject(:spreadsheet) { described_class.new([branch1, branch2], slug: 'agency-payroll-results') }

    let(:position_id) { 'RM6238.1.1' }

    describe 'the generated worksheet' do
      let(:worksheet) { workbook.worksheets.first }
      let(:workbook) { RubyXL::Parser.parse_buffer(StringIO.new(spreadsheet.to_xlsx)) }

      it 'is has the name Suppliers' do
        expect(worksheet.sheet_name).to eq 'Agency shortlist'
      end

      it 'has two header row and two data rows' do
        expect(worksheet.to_a.size).to eq 4
      end

      it 'has the correct header row 1' do
        expect(worksheet[0].cells.map(&:value)).to eq [
          'Agency list'
        ]
      end

      it 'has the correct header row 2' do
        expect(worksheet[1].cells.map(&:value)).to eq [
          'Agency name',
          'Branch name',
          'Contact name',
          'Contact email',
          'Telephone number',
          'Supplier fee',
          'Miles'
        ]
      end

      it 'has the correct data for branch 1' do
        expect(worksheet[2].cells.map(&:value)).to eq [
          branch1.supplier_name,
          branch1.name,
          branch1.contact_name,
          branch1.contact_email,
          branch1.telephone_number,
          100.0,
          1.0
        ]
      end

      it 'has the correct data for branch 2' do
        expect(worksheet[3].cells.map(&:value)).to eq [
          branch2.supplier_name,
          branch2.name,
          branch2.contact_name,
          branch2.contact_email,
          branch2.telephone_number,
          200.0,
          2.0
        ]
      end

      context 'when the phone number is valid' do
        let(:telephone_number) { '01214960123' }

        it 'is formatted' do
          expect(worksheet[2].cells.map(&:value)[4])
            .to eq('0121 496 0123')
        end
      end

      context 'when the phone number is invalid' do
        let(:telephone_number) { '0111111111111' }

        it 'does not become a number' do
          expect(worksheet[2].cells.map(&:value)[4])
            .to eq(telephone_number)
        end
      end
    end
  end

  context 'with fixed term results' do
    subject(:spreadsheet) { described_class.new([branch1, branch2], slug: 'fixed-term-results') }

    let(:position_id) { 'RM6238.1.11' }

    describe 'the generated worksheet' do
      let(:worksheet) { workbook.worksheets.first }
      let(:workbook) { RubyXL::Parser.parse_buffer(StringIO.new(spreadsheet.to_xlsx)) }

      it 'is has the name Suppliers' do
        expect(worksheet.sheet_name).to eq 'Agency shortlist'
      end

      it 'has two header row and two data rows' do
        expect(worksheet.to_a.size).to eq 4
      end

      it 'has the correct header row 1' do
        expect(worksheet[0].cells.map(&:value)).to eq [
          'Agency list'
        ]
      end

      it 'has the correct header row 2' do
        expect(worksheet[1].cells.map(&:value)).to eq [
          'Agency name',
          'Branch name',
          'Contact name',
          'Contact email',
          'Telephone number',
          'Supplier fee',
          'Miles'
        ]
      end

      it 'has the correct data for branch 1' do
        expect(worksheet[2].cells.map(&:value)).to eq [
          branch1.supplier_name,
          branch1.name,
          branch1.contact_name,
          branch1.contact_email,
          branch1.telephone_number,
          1.0,
          1.0
        ]
      end

      it 'has the correct data for branch 2' do
        expect(worksheet[3].cells.map(&:value)).to eq [
          branch2.supplier_name,
          branch2.name,
          branch2.contact_name,
          branch2.contact_email,
          branch2.telephone_number,
          2.0,
          2.0
        ]
      end
    end
  end
end
