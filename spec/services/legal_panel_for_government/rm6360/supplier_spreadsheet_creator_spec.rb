require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::SupplierSpreadsheetCreator do
  let(:supplier_details) do
    [
      { name: 'COLONY 4 CORP', email: 'ethel@colony.four.ltd.com 4 CORP', telephone_number: '0203 234 5678', additional_details: { "lot_#{lot_number}_prospectus_link": 'colony.four@xenoblade3.com' } },
      { name: 'MAKTHA AGENCY', email: 'juniper@flowers.com', telephone_number: '0204 345 6789', additional_details: { "lot_#{lot_number}_prospectus_link": 'maktha@xenoblade3.com' } },
      { name: 'KEVIS CASTLE SERVICE', email: 'melia@kevis.castle.com', telephone_number: '0204 567 8901', additional_details: { "lot_#{lot_number}_prospectus_link": 'kevis.castle@xenoblade3.com' } },
    ]
  end
  let(:supplier_frameworks) { Supplier::Framework.joins(:supplier).order('supplier.name ASC').map { |supplier_framework| [supplier_framework, supplier_framework.grouped_rates_for_lot_and_jurisdictions(lot_id, jurisdiction_ids)] } }
  let(:lot_number) { '1' }
  let(:lot_id) { "RM6360.#{lot_number}" }
  let(:services) { Service.where(lot_id:).sample(5).sort_by(&:id) }
  let(:service_ids) { services.map(&:id) }
  let(:central_government) { 'yes' }
  let(:jurisdiction_ids) { ['GB'] }
  let(:params) { { 'central_government' => central_government, 'service_ids' => service_ids, 'lot_id' => lot_id } }
  let(:spreadsheet_creator) { described_class.new(supplier_frameworks, params) }

  let(:work_book) do
    File.write('/tmp/lpg_supplier_spreadsheet.xlsx', spreadsheet_creator.build.to_stream.read, binmode: true)
    Roo::Excelx.new('/tmp/lpg_supplier_spreadsheet.xlsx')
  end

  before do
    position_ids = Lot.find(lot_id).positions.pluck(:id)

    supplier_details.each.with_index(1) do |supplier_detail, index_1|
      supplier = create(:supplier, name: supplier_detail[:name])
      supplier_framework = create(:supplier_framework, supplier:)
      supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

      create(:supplier_framework_contact_detail, supplier_framework:, **supplier_detail.except(:name))

      jurisdiction_ids.each.with_index(1) do |jurisdiction_id, index_2|
        supplier_framework_lot_jurisdiction_id = create(:supplier_framework_lot_jurisdiction, supplier_framework_lot:, jurisdiction_id:).id

        position_ids.each.with_index(1) do |position_id, index_3|
          create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction_id, position_id: position_id, rate: 10 * "#{index_1}#{index_2}#{index_3}".to_i)
        end
      end
    end
  end

  describe '.build' do
    it 'returns an Axlsx::Package' do
      spreadsheet = spreadsheet_creator.build
      expect(spreadsheet.class).to eq(Axlsx::Package)
    end
  end

  # rubocop:disable RSpec/NestedGroups
  context 'when considering the results spreadsheet' do
    # rubocop:disable RSpec/MultipleExpectations
    context 'when considering the Supplier shortlist sheet' do
      let(:sheet) { work_book.sheet('Supplier shortlist') }

      it 'has the correct rows' do
        expect(sheet.row(1)).to eq ['Supplier name', 'Phone number', 'Email', 'Prospectus']
        expect(sheet.row(2)).to eq ['COLONY 4 CORP', '0203 234 5678', 'ethel@colony.four.ltd.com 4 CORP', 'colony.four@xenoblade3.com']
        expect(sheet.row(3)).to eq ['KEVIS CASTLE SERVICE', '0204 567 8901', 'melia@kevis.castle.com', 'kevis.castle@xenoblade3.com']
        expect(sheet.row(4)).to eq ['MAKTHA AGENCY', '0204 345 6789', 'juniper@flowers.com', 'maktha@xenoblade3.com']
      end
    end

    context 'when considering the Shortlist audit sheet' do
      let(:sheet) { work_book.sheet('Shortlist audit') }

      context 'and the lot number is 1' do
        it 'has the correct data' do
          expect(sheet.row(1)).to eq ['Lot', '1 - Core Legal Services']
          expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
          expect(sheet.row(3)).to eq [nil, nil]
        end
      end

      context 'and the lot number is 4a' do
        let(:lot_number) { '4a' }

        context 'and not core jurisdictions is no' do
          let(:params) { super().merge({ 'not_core_jurisdiction' => 'no' }) }

          it 'has the correct data' do
            expect(sheet.row(1)).to eq ['Lot', '4a - Trade and Investment Negotiations']
            expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
            expect(sheet.row(3)).to eq ['Countries', 'Belgium; Canada; France; Germany; Ireland; Switzerland; United Kingdom; United States']
          end
        end

        context 'and not core jurisdictions is yes' do
          let(:params) { super().merge({ 'jurisdiction_ids' => ['AE', 'AX'], 'not_core_jurisdiction' => 'yes' }) }

          it 'has the correct data' do
            expect(sheet.row(1)).to eq ['Lot', '4a - Trade and Investment Negotiations']
            expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
            expect(sheet.row(3)).to eq ['Countries', 'United Arab Emirates; Åland Islands']
          end
        end
      end
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  context 'when considering the rates spreadsheet' do
    context 'when suppliers have not been selected' do
      let(:params) { super().merge({ 'have_you_reviewed' => 'no' }) }

      context 'when considering the Shortlist audit sheet' do
        let(:sheet) { work_book.sheet('Shortlist audit') }

        context 'and the lot number is 1' do
          it 'has the correct data' do
            expect(sheet.row(1)).to eq ['Lot', '1 - Core Legal Services']
            expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
            expect(sheet.row(3)).to eq [nil, nil]
          end
        end

        context 'and the lot number is 4a' do
          let(:lot_number) { '4a' }

          context 'and not core jurisdictions is no' do
            let(:params) { super().merge({ 'not_core_jurisdiction' => 'no' }) }

            it 'has the correct data' do
              expect(sheet.row(1)).to eq ['Lot', '4a - Trade and Investment Negotiations']
              expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
              expect(sheet.row(3)).to eq ['Countries', 'Belgium; Canada; France; Germany; Ireland; Switzerland; United Kingdom; United States']
            end
          end

          context 'and not core jurisdictions is yes' do
            let(:jurisdiction_ids) { ['BW', 'UG'] }
            let(:params) { super().merge({ 'jurisdiction_ids' => jurisdiction_ids, 'not_core_jurisdiction' => 'yes' }) }

            it 'has the correct data' do
              expect(sheet.row(1)).to eq ['Lot', '4a - Trade and Investment Negotiations']
              expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
              expect(sheet.row(3)).to eq ['Countries', 'Botswana; Uganda']
            end
          end
        end
      end

      # rubocop:disable RSpec/MultipleExpectations
      context 'when considering the Supplier rates sheet' do
        let(:sheet) { work_book.sheet('Supplier rates') }

        context 'and the lot number is 1' do
          it 'has the correct rows' do
            expect(sheet.row(1)).to eq ['Supplier name', 'Prospectus', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant']
            expect(sheet.row(2)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£11.10', '£11.20', '£11.30', '£11.40', '£11.50', '£11.60', '£11.70']
            expect(sheet.row(3)).to eq ['KEVIS CASTLE SERVICE', 'kevis.castle@xenoblade3.com', '£31.10', '£31.20', '£31.30', '£31.40', '£31.50', '£31.60', '£31.70']
            expect(sheet.row(4)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£21.10', '£21.20', '£21.30', '£21.40', '£21.50', '£21.60', '£21.70']
          end
        end

        context 'and the lot number is 4a' do
          let(:lot_number) { '4a' }

          context 'and not core jurisdictions is no' do
            let(:params) { super().merge({ 'not_core_jurisdiction' => 'no' }) }

            it 'has the correct rows' do
              expect(sheet.row(1)).to eq ['Countries:', 'Belgium; Canada; France; Germany; Ireland; Switzerland; United Kingdom; United States', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
              expect(sheet.row(2)).to eq ['Supplier name', 'Prospectus', 'Senior Counsel, Senior Partner (20 years +PQE)', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Senior Analyst', 'Analyst, Associate Analyst, Research Associate, Research Officer', 'Senior Modeller, Senior Econometrician, Senior Analyst', 'Modeller, Econometrician, Analyst, Associate Analyst']
              expect(sheet.row(3)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£11.10', '£11.20', '£11.30', '£11.40', '£11.50', '£11.60', '£11.70', '£11.80', '£11.90', '£111.00', '£111.10', '£111.20']
              expect(sheet.row(4)).to eq ['KEVIS CASTLE SERVICE', 'kevis.castle@xenoblade3.com', '£31.10', '£31.20', '£31.30', '£31.40', '£31.50', '£31.60', '£31.70', '£31.80', '£31.90', '£311.00', '£311.10', '£311.20']
              expect(sheet.row(5)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£21.10', '£21.20', '£21.30', '£21.40', '£21.50', '£21.60', '£21.70', '£21.80', '£21.90', '£211.00', '£211.10', '£211.20']
            end
          end

          context 'and not core jurisdictions is yes' do
            let(:jurisdiction_ids) { ['BW', 'UG'] }
            let(:params) { super().merge({ 'jurisdiction_ids' => jurisdiction_ids, 'not_core_jurisdiction' => 'yes' }) }

            context 'when considering the sheet for Botswana' do
              let(:sheet) { work_book.sheet('Supplier rates (BW)') }

              it 'has the correct rows' do
                expect(sheet.row(1)).to eq ['Country:', 'Botswana', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
                expect(sheet.row(2)).to eq ['Supplier name', 'Prospectus', 'Senior Counsel, Senior Partner (20 years +PQE)', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Senior Analyst', 'Analyst, Associate Analyst, Research Associate, Research Officer', 'Senior Modeller, Senior Econometrician, Senior Analyst', 'Modeller, Econometrician, Analyst, Associate Analyst']
                expect(sheet.row(3)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£11.10', '£11.20', '£11.30', '£11.40', '£11.50', '£11.60', '£11.70', '£11.80', '£11.90', '£111.00', '£111.10', '£111.20']
                expect(sheet.row(4)).to eq ['KEVIS CASTLE SERVICE', 'kevis.castle@xenoblade3.com', '£31.10', '£31.20', '£31.30', '£31.40', '£31.50', '£31.60', '£31.70', '£31.80', '£31.90', '£311.00', '£311.10', '£311.20']
                expect(sheet.row(5)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£21.10', '£21.20', '£21.30', '£21.40', '£21.50', '£21.60', '£21.70', '£21.80', '£21.90', '£211.00', '£211.10', '£211.20']
              end
            end

            context 'when considering the sheet for Uganda' do
              let(:sheet) { work_book.sheet('Supplier rates (UG)') }

              it 'has the correct rows' do
                expect(sheet.row(1)).to eq ['Country:', 'Uganda', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
                expect(sheet.row(2)).to eq ['Supplier name', 'Prospectus', 'Senior Counsel, Senior Partner (20 years +PQE)', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Senior Analyst', 'Analyst, Associate Analyst, Research Associate, Research Officer', 'Senior Modeller, Senior Econometrician, Senior Analyst', 'Modeller, Econometrician, Analyst, Associate Analyst']
                expect(sheet.row(3)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£12.10', '£12.20', '£12.30', '£12.40', '£12.50', '£12.60', '£12.70', '£12.80', '£12.90', '£121.00', '£121.10', '£121.20']
                expect(sheet.row(4)).to eq ['KEVIS CASTLE SERVICE', 'kevis.castle@xenoblade3.com', '£32.10', '£32.20', '£32.30', '£32.40', '£32.50', '£32.60', '£32.70', '£32.80', '£32.90', '£321.00', '£321.10', '£321.20']
                expect(sheet.row(5)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£22.10', '£22.20', '£22.30', '£22.40', '£22.50', '£22.60', '£22.70', '£22.80', '£22.90', '£221.00', '£221.10', '£221.20']
              end
            end
          end
        end
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when suppliers have been selected' do
      let(:params) { super().merge({ 'have_you_reviewed' => 'yes', 'supplier_framework_ids' => Supplier::Framework.joins(:supplier).where(supplier: { name: ['COLONY 4 CORP', 'MAKTHA AGENCY'] }).pluck(:id) }) }

      context 'when considering the Shortlist audit sheet' do
        let(:sheet) { work_book.sheet('Shortlist audit') }

        context 'and the lot number is 1' do
          it 'has the correct data' do
            expect(sheet.row(1)).to eq ['Lot', '1 - Core Legal Services']
            expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
            expect(sheet.row(3)).to eq [nil, nil]
          end
        end

        context 'and the lot number is 4a' do
          let(:lot_number) { '4a' }

          context 'and not core jurisdictions is no' do
            let(:params) { super().merge({ 'not_core_jurisdiction' => 'no' }) }

            it 'has the correct data' do
              expect(sheet.row(1)).to eq ['Lot', '4a - Trade and Investment Negotiations']
              expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
              expect(sheet.row(3)).to eq ['Countries', 'Belgium; Canada; France; Germany; Ireland; Switzerland; United Kingdom; United States']
            end
          end

          context 'and not core jurisdictions is yes' do
            let(:jurisdiction_ids) { ['BW', 'UG'] }
            let(:params) { super().merge({ 'jurisdiction_ids' => jurisdiction_ids, 'not_core_jurisdiction' => 'yes' }) }

            it 'has the correct data' do
              expect(sheet.row(1)).to eq ['Lot', '4a - Trade and Investment Negotiations']
              expect(sheet.row(2)).to eq ['Specialisms', services.map(&:name).join('; ')]
              expect(sheet.row(3)).to eq ['Countries', 'Botswana; Uganda']
            end
          end
        end
      end

      # rubocop:disable RSpec/MultipleExpectations
      context 'when considering the Supplier rates sheet' do
        let(:sheet) { work_book.sheet('Supplier rates') }

        context 'and the lot number is 1' do
          it 'has the correct rows' do
            expect(sheet.row(1)).to eq ['Supplier name', 'Prospectus', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant']
            expect(sheet.row(2)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£11.10', '£11.20', '£11.30', '£11.40', '£11.50', '£11.60', '£11.70']
            expect(sheet.row(4)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£21.10', '£21.20', '£21.30', '£21.40', '£21.50', '£21.60', '£21.70']
          end
        end

        context 'and the lot number is 4a' do
          let(:lot_number) { '4a' }

          context 'and not core jurisdictions is no' do
            let(:params) { super().merge({ 'not_core_jurisdiction' => 'no' }) }

            it 'has the correct rows' do
              expect(sheet.row(1)).to eq ['Countries:', 'Belgium; Canada; France; Germany; Ireland; Switzerland; United Kingdom; United States', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
              expect(sheet.row(2)).to eq ['Supplier name', 'Prospectus', 'Senior Counsel, Senior Partner (20 years +PQE)', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Senior Analyst', 'Analyst, Associate Analyst, Research Associate, Research Officer', 'Senior Modeller, Senior Econometrician, Senior Analyst', 'Modeller, Econometrician, Analyst, Associate Analyst']
              expect(sheet.row(3)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£11.10', '£11.20', '£11.30', '£11.40', '£11.50', '£11.60', '£11.70', '£11.80', '£11.90', '£111.00', '£111.10', '£111.20']
              expect(sheet.row(5)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£21.10', '£21.20', '£21.30', '£21.40', '£21.50', '£21.60', '£21.70', '£21.80', '£21.90', '£211.00', '£211.10', '£211.20']
            end
          end

          context 'and not core jurisdictions is yes' do
            let(:jurisdiction_ids) { ['BW', 'UG'] }
            let(:params) { super().merge({ 'jurisdiction_ids' => jurisdiction_ids, 'not_core_jurisdiction' => 'yes' }) }

            context 'when considering the sheet for Botswana' do
              let(:sheet) { work_book.sheet('Supplier rates (BW)') }

              it 'has the correct rows' do
                expect(sheet.row(1)).to eq ['Country:', 'Botswana', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
                expect(sheet.row(2)).to eq ['Supplier name', 'Prospectus', 'Senior Counsel, Senior Partner (20 years +PQE)', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Senior Analyst', 'Analyst, Associate Analyst, Research Associate, Research Officer', 'Senior Modeller, Senior Econometrician, Senior Analyst', 'Modeller, Econometrician, Analyst, Associate Analyst']
                expect(sheet.row(3)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£11.10', '£11.20', '£11.30', '£11.40', '£11.50', '£11.60', '£11.70', '£11.80', '£11.90', '£111.00', '£111.10', '£111.20']
                expect(sheet.row(5)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£21.10', '£21.20', '£21.30', '£21.40', '£21.50', '£21.60', '£21.70', '£21.80', '£21.90', '£211.00', '£211.10', '£211.20']
              end
            end

            context 'when considering the sheet for Uganda' do
              let(:sheet) { work_book.sheet('Supplier rates (UG)') }

              it 'has the correct rows' do
                expect(sheet.row(1)).to eq ['Country:', 'Uganda', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
                expect(sheet.row(2)).to eq ['Supplier name', 'Prospectus', 'Senior Counsel, Senior Partner (20 years +PQE)', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Senior Analyst', 'Analyst, Associate Analyst, Research Associate, Research Officer', 'Senior Modeller, Senior Econometrician, Senior Analyst', 'Modeller, Econometrician, Analyst, Associate Analyst']
                expect(sheet.row(3)).to eq ['COLONY 4 CORP', 'colony.four@xenoblade3.com', '£12.10', '£12.20', '£12.30', '£12.40', '£12.50', '£12.60', '£12.70', '£12.80', '£12.90', '£121.00', '£121.10', '£121.20']
                expect(sheet.row(5)).to eq ['MAKTHA AGENCY', 'maktha@xenoblade3.com', '£22.10', '£22.20', '£22.30', '£22.40', '£22.50', '£22.60', '£22.70', '£22.80', '£22.90', '£221.00', '£221.10', '£221.20']
              end
            end
          end
        end
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
  # rubocop:enable RSpec/NestedGroups
end
