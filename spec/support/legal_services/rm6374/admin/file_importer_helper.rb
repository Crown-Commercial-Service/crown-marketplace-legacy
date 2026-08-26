module LegalServices
  module RM6374
    module Admin
      class FileImporterHelper
        def initialize(**options)
          @package = Axlsx::Package.new
          @sheets = options[:sheets]
          @headers = options[:headers]
          @supplier_duns = options[:supplier_duns] || {}
          @empty = options[:empty] || false
        end

        def supplier_heading_name(name, duns)
          "#{name} [#{duns}]"
        end

        def write
          File.write(self.class::OUTPUT_PATH, @package.to_stream.read, binmode: true)
        end

        SUPPLIERS_LOT_1A = [
          ['NOAH LTD', 'noah@xenoblade3.com', '0202 123 4567', 'www.noah.com', 'Keves AA3 1XC', 'Yes', '123456789'],
          ['MIO CORP', 'mio@xenoblade3.com', '0203 234 5678', 'www.mio.com', 'Agnus AA3 2XC', 'No', '234567891'],
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912']
        ].freeze

        SUPPLIERS_LOT_1B = [
          ['NOAH LTD', 'noah@xenoblade3.com', '0202 123 4567', 'www.noah.com', 'Keves AA3 1XC', 'Yes', '123456789'],
          ['MIO CORP', 'mio@xenoblade3.com', '0203 234 5678', 'www.mio.com', 'Agnus AA3 2XC', 'No', '234567891'],
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912']
        ].freeze

        SUPPLIERS_LOT_1C = [
          ['NOAH LTD', 'noah@xenoblade3.com', '0202 123 4567', 'www.noah.com', 'Keves AA3 1XC', 'Yes', '123456789'],
          ['MIO CORP', 'mio@xenoblade3.com', '0203 234 5678', 'www.mio.com', 'Agnus AA3 2XC', 'No', '234567891'],
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912']
        ].freeze

        SUPPLIERS_LOT_2 = [
          ['REKU LTD', 'reku@xenoblade3.com', '0204 345 6789', 'www.reku.com', 'Colony 9 AA3 3XC', 'Yes', '345678912'],
          ['GUERNICA EXEC CORP', 'guernica@xenoblade3.com', '0205 456 7890', 'www.guernica.com', 'Swordmarch AA3 4XC', 'No', '456789123'],
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234']
        ].freeze

        SUPPLIERS_LOT_3 = [
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234'],
          ['LANZ CORP', 'lanz@xenoblade3.com', '0205 678 9012', 'www.lanz.com', 'Colony 30 AA3 6XC', 'No', '678912345'],
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456']
        ].freeze

        SUPPLIERS_LOT_4 = [
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234'],
          ['LANZ CORP', 'lanz@xenoblade3.com', '0205 678 9012', 'www.lanz.com', 'Colony 30 AA3 6XC', 'No', '678912345'],
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456']
        ].freeze

        SUPPLIERS_LOT_5 = [
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234'],
          ['LANZ CORP', 'lanz@xenoblade3.com', '0205 678 9012', 'www.lanz.com', 'Colony 30 AA3 6XC', 'No', '678912345'],
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456']
        ].freeze

        SUPPLIERS_LOT_6 = [
          ['ETHEL LTD', 'ethel@xenoblade3.com', '0204 567 8901', 'www.ethel.com', 'Colony 4 AA3 5XC', 'Yes', '567891234'],
          ['LANZ CORP', 'lanz@xenoblade3.com', '0205 678 9012', 'www.lanz.com', 'Colony 30 AA3 6XC', 'No', '678912345'],
          ['EUNIE CORP', 'eunie@xenoblade3.com', '0206 789 0123', 'www.eunie.com', 'Colony 12 AA3 7XC', 'Yes', '789123456']
        ].freeze
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
        HEADERS = ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1a: Prospectus Link', 'Lot 1b: Prospectus Link', 'Lot 1c: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4: Prospectus Link', 'Lot 5: Prospectus Link', 'Lot 6: Prospectus Link'].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            headers = self::HEADERS
            headers += ['Extra'] if sheets_with_extra_headers.include? sheet
            headers
          end
        end

        private

        def add_supplier_sheet(sheet_name, header_row)
          supplier_details = (SUPPLIERS_LOT_1A + SUPPLIERS_LOT_1B + SUPPLIERS_LOT_1C + SUPPLIERS_LOT_2 + SUPPLIERS_LOT_3 + SUPPLIERS_LOT_4 + SUPPLIERS_LOT_5 + SUPPLIERS_LOT_6).uniq

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row
            next if @empty

            supplier_details.each do |supplier_detail|
              sheet.add_row supplier_detail
            end
          end
        end
      end

      class SupplierRateCardsFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= SHEETS
          options[:headers] ||= options[:sheets].map do |sheet_name|
            if sheet_name == '6'
              [self.class::HEADERS_1_FOR_LOT_6, self.class::HEADERS_2_FOR_LOT_6]
            else
              [self.class::HEADERS_1, self.class::HEADERS_2]
            end
          end

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_row|
            add_rate_card_sheet(sheet_name, header_row)
          end
        end

        OUTPUT_PATH = './tmp/test_supplier_rate_cards_file.xlsx'.freeze

        SHEETS = ['1a', '1b', '1c', '2', '3', '4', '5', '6'].freeze
        HEADERS_1 = [nil, 'Position:', 'Partner', 'Legal Director/ Counsel or equivalent', 'Senior Solicitor, Senior Associate/Senior Legal Executive', 'Solicitor, Associate/Legal Executive', 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive', 'Trainee/Legal Apprentice', 'Paralegal, Legal Assistant', 'Legal Project Managers', 'Legal Document Reviewers, Document Reviewers'].freeze
        HEADERS_2 = ['Supplier name', 'DUNS', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate'].freeze
        PRICES = [1330, 1295, 1225, 1120, 700, 450, 300, 250, 100].freeze
        HEADERS_1_FOR_LOT_6 = [nil, 'Position:', 'Grade A: Individual with more than 8 years cost litigation experience', 'Grade B: Individual with less than 4 years cost litigation experience', 'Grade C: Individual with more than 4 years cost litigation experience', 'Grade D: Individual with paralegal qualifications'].freeze
        HEADERS_2_FOR_LOT_6 = ['Supplier name', 'DUNS', 'Hourly rate', 'Hourly rate', 'Hourly rate', 'Hourly rate'].freeze
        PRICES_FOR_LOT_6 = [1000, 750, 500, 250].freeze

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            h1 = sheet == '6' ? self::HEADERS_1_FOR_LOT_6 : self::HEADERS_1
            h2 = sheet == '6' ? self::HEADERS_2_FOR_LOT_6 : self::HEADERS_2

            if sheets_with_extra_headers.include?(sheet)
              [h1 + ['Extra'], h2 + ['Extra']]
            else
              [h1, h2]
            end
          end
        end

        private

        def add_rate_card_sheet(sheet_name, header_row)
          supplier_details = suppliers(sheet_name)
          prices = sheet_name == '6' ? PRICES_FOR_LOT_6 : PRICES

          @package.workbook.add_worksheet(name: sheet_name) do |sheet|
            sheet.add_row header_row[0]
            sheet.add_row header_row[1]
            next if @empty

            supplier_details.each_with_index do |supplier_detail, _index|
              supplier_name = supplier_detail[0]
              supplier_duns = @supplier_duns[supplier_name.to_sym] || supplier_detail[6]

              sheet.add_row [supplier_name, supplier_duns] + prices
            end
          end
        end

        def suppliers(sheet_name)
          if sheet_name.include? '6'
            SUPPLIERS_LOT_6
          elsif sheet_name.include? '5'
            SUPPLIERS_LOT_5
          elsif sheet_name.include? '4'
            SUPPLIERS_LOT_4
          elsif sheet_name.include? '3'
            SUPPLIERS_LOT_3
          elsif sheet_name.include? '2'
            SUPPLIERS_LOT_2
          else
            SUPPLIERS_LOT_1A
          end
        end

        def final_rate(index)
          case index
          when 0
            1200
          when 1
            nil
          when 2
            ''
          end
        end
      end

      class SupplierLotFile < FileImporterHelper
        def initialize(**options)
          options[:sheets] ||= self.class::SHEETS
          options[:headers] ||= [self.class::HEADERS_1.zip(self.class::HEADERS_2)] * options[:sheets].count

          super
        end

        def build
          @sheets.zip(@headers).each do |sheet_name, header_column|
            add_service_offerings_sheet(sheet_name, header_column)
          end
        end

        def self.sheets_with_extra_headers(sheets_with_extra_headers)
          self::SHEETS.map do |sheet|
            h1 = self::HEADERS_1.dup
            h2 = self::HEADERS_2.dup

            if sheets_with_extra_headers.include?(sheet)
              (h1 + ['Extra']).zip(h2 + ['Extra'])
            else
              h1.zip(h2)
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
          selection = self.class::BASE_SELECTION.dup
          supplier_name_headings = supplier_names(self.class::SUPPLIERS)

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
      end

      class SupplierLot1AFile < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_1A
        OUTPUT_PATH = './tmp/test_supplier_lot_1a_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Artificial Intelligence and Machine Learning Law', 'Assimilated Law', 'Aviation and Airports', 'Charities', 'Children and Vulnerable Adults', 'Commercial Litigation and Dispute Resolution', 'Competition Law', 'Construction Law', 'Contracts', 'Corporate Finance', 'Corporate Law', 'Court of Protection', 'Criminal Law', 'Debt Recovery', 'Defence and Security Law', 'Dispute Resolution and Litigation Law', 'Education Law', 'Emerging Policy and Legal Risk Advisory', 'Employment Law', 'Energy and Natural Resources', 'Environmental Law', 'Finance and Investment', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Gaming and Gambling Law', 'Grants', 'Health and Safety', 'Health, Healthcare and Social Care', 'Housing Law', 'Immigration', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Trade', 'Life Sciences', 'Maritime and Shipping', 'Media Law', 'Merger and Acquisition Activity', 'Outsourcing', 'Partnership Law', 'Pensions Law', 'Planning Law', 'Private Law Litigation and Dispute Resolution', 'Projects/PPP', 'Property and Real Estate Litigation and Dispute Resolution', 'Public Inquiries - Support to Participants and Inquests', 'Public International Law', 'Public Law', 'Public Law Litigation and Dispute Resolution', 'Public Procurement Law', 'Real Estate and Real Estate Finance', 'Restructuring and Insolvency', 'Space Law', 'Sports Law', 'Supporting Public Inquiries', 'Sustainable Finance/ Green Finance', 'Tax Law'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '1a.1', '1a.2', '1a.3', '1a.4', '1a.5', '1a.7', '1a.8', '1a.9', '1a.10', '1a.11', '1a.12', '1a.13', '1a.15', '1a.18', '1a.19', '1a.20', '1a.21', '1a.22', '1a.23', '1a.25', '1a.26', '1a.28', '1a.31', '1a.32', '1a.33', '1a.34', '1a.35', '1a.37', '1a.38', '1a.39', '1a.41', '1a.42', '1a.43', '1a.44', '1a.45', '1a.46', '1a.50', '1a.54', '1a.56', '1a.57', '1a.58', '1a.59', '1a.60', '1a.61', '1a.62', '1a.63', '1a.66', '1a.67', '1a.70', '1a.71', '1a.72', '1a.73', '1a.74', '1a.77', '1a.79', '1a.81', '1a.82', '1a.85', '1a.86', '1a.87'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot1BFile < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_1B
        OUTPUT_PATH = './tmp/test_supplier_lot_1b_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Artificial Intelligence and Machine Learning Law', 'Assimilated Law', 'Aviation and Airports', 'Charities', 'Children and Vulnerable Adults', 'Commercial Litigation and Dispute Resolution', 'Competition Law', 'Construction Law', 'Contracts', 'Corporate Finance', 'Corporate Law', 'Court of Protection', 'Criminal Law', 'Debt Recovery', 'Defence and Security Law', 'Dispute Resolution and Litigation Law', 'Education Law', 'Emerging Policy and Legal Risk Advisory', 'Employment Law', 'Energy and Natural Resources', 'Environmental Law', 'Finance and Investment', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Gaming and Gambling Law', 'Grants', 'Health and Safety', 'Health, Healthcare and Social Care', 'Housing Law', 'Immigration', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Trade', 'Life Sciences', 'Maritime and Shipping', 'Media Law', 'Merger and Acquisition Activity', 'Outsourcing', 'Partnership Law', 'Pensions Law', 'Planning Law', 'Private Law Litigation and Dispute Resolution', 'Projects/PPP', 'Property and Real Estate Litigation and Dispute Resolution', 'Public Inquiries - Support to Participants and Inquests', 'Public International Law', 'Public Law', 'Public Law Litigation and Dispute Resolution', 'Public Procurement Law', 'Real Estate and Real Estate Finance', 'Restructuring and Insolvency', 'Space Law', 'Sports Law', 'Supporting Public Inquiries', 'Sustainable Finance/ Green Finance', 'Tax Law'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '1b.1', '1b.2', '1b.3', '1b.4', '1b.5', '1b.7', '1b.8', '1b.9', '1b.10', '1b.11', '1b.12', '1b.13', '1b.15', '1b.18', '1b.19', '1b.20', '1b.21', '1b.22', '1b.23', '1b.25', '1b.26', '1b.28', '1b.31', '1b.32', '1b.33', '1b.34', '1b.35', '1b.37', '1b.38', '1b.39', '1b.41', '1b.42', '1b.43', '1b.44', '1b.45', '1b.46', '1b.50', '1b.54', '1b.56', '1b.57', '1b.58', '1b.59', '1b.60', '1b.61', '1b.62', '1b.63', '1b.66', '1b.67', '1b.70', '1b.71', '1b.72', '1b.73', '1b.74', '1b.77', '1b.79', '1b.81', '1b.82', '1b.85', '1b.86', '1b.87'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot1CFile < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_1C
        OUTPUT_PATH = './tmp/test_supplier_lot_1c_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Artificial Intelligence and Machine Learning Law', 'Assimilated Law', 'Aviation and Airports', 'Charities', 'Children and Vulnerable Adults', 'Commercial Litigation and Dispute Resolution', 'Competition Law', 'Construction Law', 'Contracts', 'Corporate Finance', 'Corporate Law', 'Court of Protection', 'Criminal Law', 'Debt Recovery', 'Defence and Security Law', 'Dispute Resolution and Litigation Law', 'Education Law', 'Emerging Policy and Legal Risk Advisory', 'Employment Law', 'Energy and Natural Resources', 'Environmental Law', 'Finance and Investment', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Gaming and Gambling Law', 'Grants', 'Health and Safety', 'Health, Healthcare and Social Care', 'Housing Law', 'Immigration', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Trade', 'Life Sciences', 'Maritime and Shipping', 'Media Law', 'Merger and Acquisition Activity', 'Outsourcing', 'Partnership Law', 'Pensions Law', 'Planning Law', 'Private Law Litigation and Dispute Resolution', 'Projects/PPP', 'Property and Real Estate Litigation and Dispute Resolution', 'Public Inquiries - Support to Participants and Inquests', 'Public International Law', 'Public Law', 'Public Law Litigation and Dispute Resolution', 'Public Procurement Law', 'Real Estate and Real Estate Finance', 'Restructuring and Insolvency', 'Space Law', 'Sports Law', 'Supporting Public Inquiries', 'Sustainable Finance/ Green Finance', 'Tax Law'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '1c.1', '1c.2', '1c.3', '1c.4', '1c.5', '1c.7', '1c.8', '1c.9', '1c.10', '1c.11', '1c.12', '1c.13', '1c.15', '1c.18', '1c.19', '1c.20', '1c.21', '1c.22', '1c.23', '1c.25', '1c.26', '1c.28', '1c.31', '1c.32', '1c.33', '1c.34', '1c.35', '1c.37', '1c.38', '1c.39', '1c.41', '1c.42', '1c.43', '1c.44', '1c.45', '1c.46', '1c.50', '1c.54', '1c.56', '1c.57', '1c.58', '1c.59', '1c.60', '1c.61', '1c.62', '1c.63', '1c.66', '1c.67', '1c.70', '1c.71', '1c.72', '1c.73', '1c.74', '1c.77', '1c.79', '1c.81', '1c.82', '1c.85', '1c.86', '1c.87'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot2File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_2
        OUTPUT_PATH = './tmp/test_supplier_lot_2_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Artificial Intelligence and Machine Learning Law', 'Assimilated Law', 'Aviation and Airports', 'Charities', 'Children and Vulnerable Adults', 'Competition Law', 'Construction Law', 'Contracts', 'Corporate Finance', 'Corporate Law', 'Court of Protection', 'Credit Insurance and Related Products', 'Criminal Law', 'Crofting', 'Debt Capital Markets', 'Debt Recovery', 'Defence and Security Law', 'Education Law', 'Emerging Policy and Legal Risk Advisory', 'Employment Law', 'Energy and Natural Resources', 'Environmental Law', 'Equity Capital Markets', 'Finance and Investment', 'Financial Institutions Rescue, Restructuring and Insolvency', 'Financial Services, Market and Competition Regulation', 'Fintech Crypto Assets', 'Food, Rural and Environmental Affairs', 'Franchise Law', 'Gaming and Gambling Law', 'Grants', 'Health and Safety', 'Health, Healthcare and Social Care', 'Housing Law', 'Immigration', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Development/Aid Funding', 'International Finance Organisations', 'International Trade', 'Investment and Asset Management', 'Investment and Commercial Banking', 'Islamic Finance / Sukuk', 'Life Sciences', 'Maritime and Shipping', 'Media Law', 'Merger and Acquisition Activity', 'Outsourcing', 'Partnership Law', 'Pensions Law', 'Planning Law', 'Project and Asset Finance', 'Projects and Transactions', 'Property and Real Estate Litigation and Dispute Resolution', 'Public Inquiries - Non-Statutory Independent Inquiries/ Reviews', 'Public Inquiries - Support to Participants and Inquests', 'Public International Law', 'Public Law', 'Public Procurement Law', 'Real Estate and Real Estate Finance', 'Restructuring and Insolvency', 'Sovereign Debt Restructuring', 'Space Law', 'Sports Law', 'Sustainable Finance/ Green Finance', 'Tax Law', 'United States Securities & Regulatory'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '2.1', '2.2', '2.3', '2.4', '2.5', '2.8', '2.9', '2.10', '2.11', '2.12', '2.13', '2.14', '2.15', '2.16', '2.17', '2.18', '2.19', '2.21', '2.22', '2.23', '2.25', '2.26', '2.27', '2.28', '2.29', '2.31', '2.32', '2.33', '2.34', '2.35', '2.37', '2.38', '2.39', '2.41', '2.42', '2.43', '2.44', '2.45', '2.46', '2.47', '2.48', '2.50', '2.51', '2.52', '2.53', '2.54', '2.56', '2.57', '2.58', '2.59', '2.60', '2.61', '2.62', '2.64', '2.65', '2.67', '2.69', '2.70', '2.71', '2.72', '2.74', '2.77', '2.79', '2.80', '2.81', '2.82', '2.86', '2.87', '2.88'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot3File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_3
        OUTPUT_PATH = './tmp/test_supplier_lot_3_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Commercial Litigation and Dispute Resolution', 'Debt Recovery', 'Dispute Resolution and Litigation Law', 'Employment Litigation and Dispute Resolution', 'Financial Litigation', 'Private Law Litigation and Dispute Resolution', 'Property and Real Estate Litigation and Dispute Resolution', 'Public Law Litigation and Dispute Resolution', 'Statutory Civil Recovery'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '3.7', '3.18', '3.20', '3.24', '3.30', '3.63', '3.67', '3.73', '3.83'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot4File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_4
        OUTPUT_PATH = './tmp/test_supplier_lot_4_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Competition Law', 'Construction Law', 'Contracts', 'Litigation and Dispute Resolution', 'Planning Law', 'Project and Asset Finance', 'Projects and Transactions', 'Property, Real Estate and Real Estate Finance', 'Public Law', 'Public Procurement Law', 'Public-Private Partnerships (PPP)'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '4.8', '4.9', '4.10', '4.55', '4.62', '4.64', '4.65', '4.68', '4.72', '4.74', '4.75'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot5File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_5
        OUTPUT_PATH = './tmp/test_supplier_lot_5_service_offerings_file.xlsx'.freeze
        SHEETS = ['England & Wales', 'Scotland', 'Northern Ireland'].freeze
        HEADERS_1 = ['', 'Service name', 'Assimilated Law', 'Aviation and Airports', 'Competition Law', 'Dispute Resolution and Litigation Law', 'Employment Law', 'Environmental Law', 'Health and Safety', 'Highways Law', 'Information Law including Data Protection Law', 'Information Technology Law', 'Insurance and Reinsurance', 'Intellectual Property Law', 'International Law', 'Maritime and Shipping', 'Pensions Law', 'Planning Law', 'Public Procurement Law', 'Rail Commercial Law', 'Real Estate and Real Estate Finance', 'Regulatory Law', 'Restructuring and Insolvency', 'Subsidy Control Law', 'Tax Law'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '5.2', '5.3', '5.8', '5.20', '5.23', '5.26', '5.38', '5.40', '5.43', '5.44', '5.45', '5.46', '5.49', '5.56', '5.61', '5.62', '5.74', '5.76', '5.77', '5.78', '5.79', '5.84', '5.87'].freeze
        BASE_SELECTION = ['x', nil, 'x'].freeze
      end

      class SupplierLot6File < SupplierLotFile
        SUPPLIERS = SUPPLIERS_LOT_6
        OUTPUT_PATH = './tmp/test_supplier_lot_6_service_offerings_file.xlsx'.freeze
        SHEETS = ['All regions'].freeze
        HEADERS_1 = ['', 'Service name', 'Clinical Negligence Specialist Services', 'General Costs Law Services'].freeze
        HEADERS_2 = ['Supplier name:', 'DUNS:', '6.6', '6.36'].freeze
        BASE_SELECTION = ['x', 'x', 'x'].freeze
      end
    end
  end
end
