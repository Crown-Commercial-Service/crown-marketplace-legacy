module LegalPanelForGovernment
  module RM6360
    module Admin
      class FileImporterHelper
        def initialize(**options)
          @package = Axlsx::Package.new
          @sheets = options[:sheets]
          @headers = options[:headers]
          @supplier_duns = options[:supplier_duns] || {}
          @empty = options[:empty] || false
        end

        def write
          File.write(self.class::OUTPUT_PATH, @package.to_stream.read, binmode: true)
        end

        SUPPLIERS_LOT_1 = [
          ['NOAH LTD', 'noah@xenoblade3.com', '0202 123 4567', 'www.noah.com', 'Keves AA3 1XC', 'Yes', '123456789', 'www.noah.com', '', '', '', '', '', ''],
          ['MIO CORP', 'mio@xenoblade3.com', '0203 234 5678', 'www.mio.com', 'Agnus AA3 2XC', 'No', '234567891', 'www.mio.com', '', '', '', '', '', ''],
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912', 'www.reku.com', 'www.reku.com', '', '', '', '', '']
        ].freeze

        SUPPLIERS_LOT_2 = [
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912', 'www.reku.com', 'www.reku.com', '', '', '', '', ''],
          ['GUERNICA EXEC CORP', 'guernica@xenoblade3.com', '0205 456 7890', 'www.guernica.com', 'Swordmarch AA3 4XC', 'No', '456789123', '', 'www.guernica.com', '', '', '', '', ''],
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234', '', 'www.ethel.com', 'www.ethel.com', '', '', '', ''],
        ].freeze

        SUPPLIERS_LOT_3 = [
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234', '', 'www.ethel.com', 'www.ethel.com', '', '', '', ''],
          ['LANZ CORP', 'lanz@xenoblade3.com', '0205 678 9012', 'www.lanz.com', 'Colony 30 AA3 6XC', 'No', '678912345', '', '', 'www.lanz.com', '', '', '', ''],
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456', '', '', 'www.eunie.com', 'www.eunie.com', 'www.eunie.com', 'www.eunie.com', ''],
        ].freeze

        SUPPLIERS_LOT_4 = [
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456', '', '', 'www.eunie.com', 'www.eunie.com', 'www.eunie.com', 'www.eunie.com', ''],
          ['SENA LTD', 'sena@xenoblade3.com', '0207 890 1234', 'www.sena.com', 'Agnus AA3 2XC', 'Yes', '891234567', '', '', '', 'www.sena.com', 'www.sena.com', 'www.sena.com', ''],
          ['TAION LTD', 'taion@xenoblade3.com', '0208 901 2345', 'www.taion.com', 'Agnus AA3 2XC', 'Yes', '912345671', '', '', '', 'www.taion.com', 'www.taion.com', 'www.taion.com', 'www.taion.com'],
        ].freeze

        SUPPLIERS_LOT_5 = [
          ['TAION LTD', 'taion@xenoblade3.com', '0208 901 2345', 'www.taion.com', 'Agnus AA3 2XC', 'Yes', '912345671', '', '', '', 'www.taion.com', 'www.taion.com', 'www.taion.com', 'www.taion.com'],
          ['NIMUE CORP', 'nimue@xenoblade3.com', '0204 012 3456', 'www.nimue.com', 'Agnus Lambda AGL 3XC', 'Yes', '456129873', '', '', '', '', '', '', 'www.nimue.com'],
          ['IZURD LTD', 'izurd@xenoblade3.com', '0204 012 6731', 'www.izurd.com', 'Agnus Lambda AGL 3XC', 'Yes', '564312798', '', '', '', '', '', '', 'www.izurd.com'],
        ].freeze

        def suppliers(sheet_name)
          case sheet_name
          when 'Lot 1'
            SUPPLIERS_LOT_1
          when 'Lot 2'
            SUPPLIERS_LOT_2
          when 'Lot 3'
            SUPPLIERS_LOT_3
          when 'Lot 4', 'Lot 4a', 'Lot 4b', 'Lot 4c'
            SUPPLIERS_LOT_4
          else
            SUPPLIERS_LOT_5
          end
        end
      end

      class SupplierDetailsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= [HEADERS] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_supplier_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_details_file.xlsx'.freeze

        SHEETS = ['All Suppliers'].freeze
        HEADERS = ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4a: Prospectus Link', 'Lot 4b: Prospectus Link', 'Lot 4c: Prospectus Link', 'Lot 5: Prospectus Link'].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            headers = self::HEADERS
            headers += ['Extra'] if sheets_with_extra_headers.include? sheet
            headers
          end
        end

        private

        def add_supplier_sheet(sheet_name, header_row)
          supplier_details = (SUPPLIERS_LOT_1 + SUPPLIERS_LOT_2 + SUPPLIERS_LOT_3 + SUPPLIERS_LOT_4 + SUPPLIERS_LOT_5).uniq

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row
            next if @empty

            supplier_details.each do |supplier_detail|
              sheet.add_row supplier_detail
            end
          end
        end
      end

      class SupplierServiceOfferingsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= self.class::SHEETS
          options[:headers] ||= options[:sheets].map do |sheet|
            if HEADERS_1.include?(sheet)
              self.class::HEADERS_1[sheet].zip(self.class::HEADERS_2[sheet])
            else
              self.class::HEADERS_1['Lot 1'].zip(self.class::HEADERS_2['Lot 1'])
            end
          end

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_column|
            add_service_offerings_sheet(sheet_name, header_column)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_service_offerings_file.xlsx'.freeze
        SHEETS = ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4a', 'Lot 4b', 'Lot 4c', 'Lot 5',].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            if sheets_with_extra_headers.include? sheet
              (self::HEADERS_1[sheet] + ['Extra']).zip(self::HEADERS_2[sheet] + ['Extra'])
            else
              self::HEADERS_1[sheet].zip(self::HEADERS_2[sheet])
            end
          end
        end

        private

        def add_service_offerings_sheet(sheet_name, header_column)
          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            @empty ? add_blank_sheet(sheet, header_column) : add_sheet_with_data(sheet, header_column)
          end
        end

        def add_blank_sheet(sheet, header_column)
          sheet.add_row header_column[0]
          sheet.add_row header_column[1]
          header_column[2..].each { |service| sheet.add_row service, types: %i[string string] }
        end

        def add_sheet_with_data(sheet, header_column)
          selection = ['x', nil, 'x']
          supplier_name_headings = supplier_names(suppliers(sheet.name))

          sheet.add_row header_column[0] + supplier_name_headings[:names]
          sheet.add_row header_column[1] + supplier_name_headings[:duns]

          header_column[2..].each do |service|
            sheet.add_row service + selection.rotate!, types: %i[string string]
          end
        end

        def supplier_names(supplier_details)
          supplier_name_headings = { names: [], duns: [] }

          supplier_details.each do |supplier_detail|
            supplier_name = supplier_detail[0]
            supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

            supplier_name_headings[:names] << supplier_name
            supplier_name_headings[:duns] << supplier_duns
          end

          supplier_name_headings
        end

        HEADERS_1 = {
          'Lot 1' => ['', 'Service name', 'Assimilated Law', 'Aviation and Airports', 'Charities', 'Children and Vulnerable Adults', 'Commercial Litigation and Dispute Resolution', 'Competition Law', 'Construction Law', 'Contracts', 'Corporate Law', 'Education Law', 'Employment Law', 'Energy and Natural Resources', 'Environmental Law', 'Finance and Investment', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Grants', 'Health and Safety', 'Health, Healthcare and Social Care', 'Housing Law', 'Immigration', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Trade', 'Life Sciences', 'Maritime and Shipping', 'Media Law', 'Merger & Acquisition Activity', 'Outsourcing', 'Partnership Law', 'Pensions Law', 'Planning Law', 'Private Law Litigation and Dispute Resolution', 'Projects/PFI/PPP', 'Public Inquiries - Support to Participants and Inquests', 'Public International Law', 'Public Law', 'Public Law Litigation and dispute resolution', 'Public Procurement Law', 'Real Estate and Real Estate Finance', 'Restructuring/Insolvency', 'Supporting Public Inquiries', 'Sustainable Finance/ Green Finance', 'Tax Law'],
          'Lot 2' => ['', 'Service name', 'Assimilated Law', 'Aviation and Airports', 'Charities', 'Children and Vulnerable Adults', 'Commercial Litigation and Dispute Resolution', 'Competition Law', 'Construction Law', 'Contracts', 'Corporate Finance', 'Corporate Law', 'Credit Insurance and Related Products', 'Debt Capital Markets', 'Education Law', 'Employment Law', 'Energy and Natural Resources', 'Environmental Law', 'Equity Capital Markets', 'Finance and Investment', 'Financial Institutions Rescue, Restructuring and Insolvency', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Grants', 'Health and Safety', 'Health, Healthcare and Social Care', 'Housing Law', 'Immigration', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Development/Aid Funding', 'International Finance Organisations', 'International Trade', 'Investment and Asset Management', 'Investment and Commercial Banking', 'Islamic Finance / Sukuk', 'Life Sciences', 'Maritime and Shipping', 'Media Law', 'Merger & Acquisition Activity', 'Outsourcing', 'Partnership Law', 'Pensions Law', 'Planning Law', 'Private Law Litigation and Dispute resolution', 'Project and Asset Finance', 'Projects/PFI/PPP', 'Public Inquiries - Support to Participants and Inquests', 'Public International Law', 'Public Law', 'Public Law Litigation and Dispute Resolution', 'Public Procurement Law', 'Real Estate and Real Estate Finance', 'Restructuring/Insolvency', 'Supporting Public Inquiries', 'Sustainable Finance / Green Finance', 'Tax Law'],
          'Lot 3' => ['', 'Service name', 'Corporate Finance', 'Corporate Law', 'Credit Insurance and Related Products', 'Debt Capital Markets', 'Energy and Natural Resources', 'Equity Capital Markets', 'Financial Institutions Rescue, Restructuring and Insolvency', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Insurance and Reinsurance', 'International Development/Aid Funding', 'International Finance Organisations', 'Investment and Asset Management', 'Investment and Commercial Banking', 'Islamic Finance / Sukuk', 'Litigation and Dispute Resolution', 'Merger and Acquisition Activity', 'Project and Asset Finance', 'Projects and transactions', 'Restructuring/Insolvency', 'Sovereign Debt Restructuring', 'Sustainable Finance/ Green Finance', 'United State Securities & Regulatory'],
          'Lot 4a' => ['', 'Service name', 'Assimilated Law', 'Domestic law of jurisdictions for trade', 'FTA chapters', 'Implementation of trade agreements', 'International law of trade', 'International treaty law', 'Investment treaties', 'Legal barriers to markets', 'Trade and investment negotiations', 'Wider trading arrangements'],
          'Lot 4b' => ['', 'Service name', 'Compliance with international law', 'Domestic law of jurisdictions for trade', 'International trade disputes', 'Prevention of disputes', 'Trade remedies', 'Trade remedies investigations', 'WTO litigation and dispute resolution', 'WTO practice', 'Wider trading arrangements'],
          'Lot 4c' => ['', 'Service name', 'Domestic law of jurisdictions for trade', 'International arbitral awards', 'Investment dispute risk advice', 'Litigation and dispute resolution for trade investment disputes', 'Treaty based investment disputes'],
          'Lot 5' => ['', 'Service name', 'Competition law', 'Dispute Resolution and litigation law', 'EU law', 'Employment law', 'Environmental law', 'Health and Safety law', 'Information law including data protection law', 'Information technology law', 'Insurance law', 'Intellectual property law', 'International law', 'Pensions law', 'Planning law', 'Public procurement law', 'Rail Commercial Law', 'Real estate law', 'Regulatory law', 'Restructuring/ Insolvency law', 'Subsidy Control Law', 'Tax law'],
        }.freeze
        HEADERS_2 = {
          'Lot 1' => ['Supplier name:', 'DUNS:', 'RM6360.1.1', 'RM6360.1.2', 'RM6360.1.3', 'RM6360.1.4', 'RM6360.1.5', 'RM6360.1.6', 'RM6360.1.7', 'RM6360.1.8', 'RM6360.1.9', 'RM6360.1.10', 'RM6360.1.11', 'RM6360.1.12', 'RM6360.1.13', 'RM6360.1.14', 'RM6360.1.15', 'RM6360.1.16', 'RM6360.1.17', 'RM6360.1.18', 'RM6360.1.19', 'RM6360.1.20', 'RM6360.1.21', 'RM6360.1.22', 'RM6360.1.23', 'RM6360.1.24', 'RM6360.1.25', 'RM6360.1.26', 'RM6360.1.27', 'RM6360.1.28', 'RM6360.1.29', 'RM6360.1.30', 'RM6360.1.31', 'RM6360.1.32', 'RM6360.1.33', 'RM6360.1.34', 'RM6360.1.35', 'RM6360.1.36', 'RM6360.1.37', 'RM6360.1.38', 'RM6360.1.39', 'RM6360.1.40', 'RM6360.1.41', 'RM6360.1.42', 'RM6360.1.43', 'RM6360.1.44', 'RM6360.1.45', 'RM6360.1.46', 'RM6360.1.47', 'RM6360.1.48'],
          'Lot 2' => ['Supplier name:', 'DUNS:', 'RM6360.2.1', 'RM6360.2.2', 'RM6360.2.3', 'RM6360.2.4', 'RM6360.2.5', 'RM6360.2.6', 'RM6360.2.7', 'RM6360.2.8', 'RM6360.2.9', 'RM6360.2.10', 'RM6360.2.11', 'RM6360.2.12', 'RM6360.2.13', 'RM6360.2.14', 'RM6360.2.15', 'RM6360.2.16', 'RM6360.2.17', 'RM6360.2.18', 'RM6360.2.19', 'RM6360.2.20', 'RM6360.2.21', 'RM6360.2.22', 'RM6360.2.23', 'RM6360.2.24', 'RM6360.2.25', 'RM6360.2.26', 'RM6360.2.27', 'RM6360.2.28', 'RM6360.2.29', 'RM6360.2.30', 'RM6360.2.31', 'RM6360.2.32', 'RM6360.2.33', 'RM6360.2.34', 'RM6360.2.35', 'RM6360.2.36', 'RM6360.2.37', 'RM6360.2.38', 'RM6360.2.39', 'RM6360.2.40', 'RM6360.2.41', 'RM6360.2.42', 'RM6360.2.43', 'RM6360.2.44', 'RM6360.2.45', 'RM6360.2.46', 'RM6360.2.47', 'RM6360.2.48', 'RM6360.2.49', 'RM6360.2.50', 'RM6360.2.51', 'RM6360.2.52', 'RM6360.2.53', 'RM6360.2.54', 'RM6360.2.55', 'RM6360.2.56', 'RM6360.2.57', 'RM6360.2.58', 'RM6360.2.59'],
          'Lot 3' => ['Supplier name:', 'DUNS:', 'RM6360.3.1', 'RM6360.3.2', 'RM6360.3.3', 'RM6360.3.4', 'RM6360.3.5', 'RM6360.3.6', 'RM6360.3.7', 'RM6360.3.8', 'RM6360.3.9', 'RM6360.3.10', 'RM6360.3.11', 'RM6360.3.12', 'RM6360.3.13', 'RM6360.3.14', 'RM6360.3.15', 'RM6360.3.16', 'RM6360.3.17', 'RM6360.3.18', 'RM6360.3.19', 'RM6360.3.20', 'RM6360.3.21', 'RM6360.3.22', 'RM6360.3.23'],
          'Lot 4a' => ['Supplier name:', 'DUNS:', 'RM6360.4a.1', 'RM6360.4a.2', 'RM6360.4a.3', 'RM6360.4a.4', 'RM6360.4a.5', 'RM6360.4a.6', 'RM6360.4a.7', 'RM6360.4a.8', 'RM6360.4a.9', 'RM6360.4a.10'],
          'Lot 4b' => ['Supplier name:', 'DUNS:', 'RM6360.4b.1', 'RM6360.4b.2', 'RM6360.4b.3', 'RM6360.4b.4', 'RM6360.4b.5', 'RM6360.4b.6', 'RM6360.4b.7', 'RM6360.4b.8', 'RM6360.4b.9'],
          'Lot 4c' => ['Supplier name:', 'DUNS:', 'RM6360.4c.1', 'RM6360.4c.2', 'RM6360.4c.3', 'RM6360.4c.4', 'RM6360.4c.5'],
          'Lot 5' => ['Supplier name:', 'DUNS:', 'RM6360.5.1', 'RM6360.5.2', 'RM6360.5.3', 'RM6360.5.4', 'RM6360.5.5', 'RM6360.5.6', 'RM6360.5.7', 'RM6360.5.8', 'RM6360.5.9', 'RM6360.5.10', 'RM6360.5.11', 'RM6360.5.12', 'RM6360.5.13', 'RM6360.5.14', 'RM6360.5.15', 'RM6360.5.16', 'RM6360.5.17', 'RM6360.5.18', 'RM6360.5.19', 'RM6360.5.20'],
        }.freeze
      end

      class SupplierOtherLotsRateCardsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= [[self.class::HEADERS_1, self.class::HEADERS_2]] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_rate_card_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_other_lots_rate_cards_file.xlsx'.freeze

        SHEETS = ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 5',].freeze
        HEADERS_1 = [nil, 'Position:', 'Partner', 'Legal Director/Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal,Legal Assistant'].freeze
        HEADERS_2 = ['Supplier name', 'DUNS', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate'].freeze
        PRICES = [1458, 1247, 1036, 825, 614, 403].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            if sheets_with_extra_headers.include? sheet
              [self::HEADERS_1 + ['Extra'], self::HEADERS_2 + ['Extra']]
            else
              [self::HEADERS_1, self::HEADERS_2]
            end
          end
        end

        private

        def add_rate_card_sheet(sheet_name, header_row)
          supplier_details = suppliers(sheet_name)

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row[0]
            sheet.add_row header_row[1]
            next if @empty

            supplier_details.each do |supplier_detail|
              supplier_name = supplier_detail[0]
              supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

              sheet.add_row [supplier_name, supplier_duns] + PRICES
            end
          end
        end
      end

      class SupplierLot4RateCardsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= self.class::SHEETS
          options[:headers] ||= [[self.class::HEADERS_1, self.class::HEADERS_2]] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_column|
            add_rate_card_sheet(sheet_name, header_column)
          end
        end

        SHEETS = ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Trainee', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'].freeze
        HEADERS_1 = ['Role', 'Jurisdiction:', 'Core', 'Afghanistan', 'Åland Islands', 'Albania', 'Algeria', 'American Samoa', 'Andorra', 'Angola', 'Anguilla', 'Antarctica', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belize', 'Benin', 'Bermuda', 'Bhutan', 'Bolivia (Plurinational State of)', 'Bonaire, Sint Eustatius and Saba', 'Bosnia and Herzegovina', 'Botswana', 'Bouvet Island', 'Brazil', 'British Indian Ocean Territory', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Cayman Islands', 'Central African Republic', 'Chad', 'Chile', 'China', 'Christmas Island', 'Cocos (Keeling) Islands', 'Colombia', 'Comoros', 'Congo', 'Congo, Democratic Republic of the', 'Cook Islands', 'Costa Rica', "Côte d'Ivoire", 'Croatia', 'Cuba', 'Curaçao', 'Cyprus', 'Czechia', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Eswatini', 'Ethiopia', 'Falkland Islands (Malvinas)', 'Faroe Islands', 'Fiji', 'Finland', 'French Guiana', 'French Polynesia', 'French Southern Territories', 'Gabon', 'Gambia', 'Georgia', 'Ghana', 'Gibraltar', 'Greece', 'Greenland', 'Grenada', 'Guadeloupe', 'Guam', 'Guatemala', 'Guernsey', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Heard Island and McDonald Islands', 'Holy See', 'Honduras', 'Hong Kong', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran (Islamic Republic of)', 'Iraq', 'Isle of Man', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jersey', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', "Korea (Democratic People's Republic of)", 'Kuwait', 'Kyrgyzstan', "Lao People's Democratic Republic", 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macao', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Martinique', 'Mauritania', 'Mauritius', 'Mayotte', 'Mexico', 'Micronesia (Federated States of)', 'Moldova, Republic of', 'Monaco', 'Mongolia', 'Montenegro', 'Montserrat', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'New Caledonia', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Norfolk Island', 'North Macedonia', 'Northern Mariana Islands', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Palestine, State of', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Pitcairn', 'Poland', 'Portugal', 'Puerto Rico', 'Qatar', 'Réunion', 'Romania', 'Russian Federation', 'Rwanda', 'Saint Barthélemy', 'Saint Helena, Ascension and Tristan da Cunha', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Martin (French part)', 'Saint Pierre and Miquelon', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone', 'Sint Maarten (Dutch part)', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Georgia and the South Sandwich Islands', 'South Korea', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Svalbard and Jan Mayen', 'Sweden', 'Syrian Arab Republic', 'Taiwan', 'Tajikistan', 'Tanzania, United Republic of', 'Thailand', 'Timor-Leste', 'Togo', 'Tokelau', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Turks and Caicos Islands', 'Tuvalu', 'UAE', 'Uganda', 'Ukraine', 'United States Minor Outlying Islands', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Venezuela (Bolivarian Republic of)', 'Viet Nam', 'Virgin Islands (British)', 'Virgin Islands (U.S.)', 'Wallis and Futuna', 'Western Sahara', 'Yemen', 'Zambia', 'Zimbabwe'].freeze
        HEADERS_2 = (['Supplier name:', 'DUNS:'] + (['Hourly rate'] * 241)).freeze
        PRICES = [1330, 1295, 1225, 1120, 700, 450].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            if sheets_with_extra_headers.include? sheet
              [HEADERS_1 + ['Extra'], HEADERS_2 + ['Extra']]
            else
              [HEADERS_1, HEADERS_2]
            end
          end
        end

        private

        def add_rate_card_sheet(sheet_name, header_row)
          supplier_details = suppliers('Lot 4')
          selection = self.class::BASE_SELECTION.dup
          prices = self.class::PRICES.dup

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row[0]
            sheet.add_row header_row[1]
            next if @empty

            price = prices.rotate![0]

            supplier_details.each_with_index do |supplier_detail, _index|
              supplier_name = supplier_detail[0]
              supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

              sheet.add_row [supplier_name, supplier_duns] + selection.rotate!.map { |has_rate| has_rate ? price.to_s : '' }
            end
          end
        end

        def supplier_names(supplier_details)
          supplier_name_headings = { names: [], duns: [] }

          supplier_details.each do |supplier_detail|
            supplier_name = supplier_detail[0]
            supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

            supplier_name_headings[:names] << supplier_name
            supplier_name_headings[:duns] << supplier_duns
          end

          supplier_name_headings
        end
      end

      class SupplierLot4aRateCardsFile < SupplierLot4RateCardsFile
        OUTPUT_PATH = './tmp/test_supplier_lot_4a_rate_cards_file.xlsx'.freeze
        BASE_SELECTION = [false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false].freeze
      end

      class SupplierLot4bRateCardsFile < SupplierLot4RateCardsFile
        OUTPUT_PATH = './tmp/test_supplier_lot_4b_rate_cards_file.xlsx'.freeze
        BASE_SELECTION = [true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, false].freeze
      end

      class SupplierLot4cRateCardsFile < SupplierLot4RateCardsFile
        OUTPUT_PATH = './tmp/test_supplier_lot_4c_rate_cards_file.xlsx'.freeze
        BASE_SELECTION = [true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, true, true, false, false, true].freeze
      end
    end
  end
end
