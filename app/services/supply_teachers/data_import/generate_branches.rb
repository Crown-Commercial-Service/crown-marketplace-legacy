module SupplyTeachers
  class DataImport::GenerateBranches
    include SupplyTeachers::DataImport::Helper

    attr_reader :supplier_branches

    def initialize(current_data)
      @current_data = current_data
    end

    def generate_branches
      @supplier_branches = collate(branches.map { |row| nest(row, :branches) })
    end

    private

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def branches
      branches_data = []

      read_spreadsheet(@current_data.geographical_data_all_suppliers) do |branch_workbook|
        branch_sheet = branch_workbook.sheet('Branch details')

        branches_data = branch_sheet.parse(header_search: ['Supplier Name'])
                                    .map { |row| remap_headers(row, HEADER_MAP) }
                                    .map.with_index { |row, index| row.merge(line_no: index + 3) }
                                    .map { |row| convert_html_fields_to_text(row) }
                                    .map { |row| convert_float_fields_to_int(row) }
                                    .map { |row| strip_fields(row) }
                                    .map { |row| match_email_to_contacts(row) }
                                    .map { |row| row }
                                    .map { |row| strip_keys_with_null_or_empty_values(row) }
                                    .map { |row| strip_punctuation_from_postcode(row) }
      end

      branches_data
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def match_email_to_contacts(row)
      names = row[:contact_name].split(%r{[,/\n]+}m)
      emails = row[:email].split(/[;\s]+/)
      contacts = names.zip(emails)
      contacts = contacts.map { |(name, email)| { name:, email: } }
      new_row = if names.count == emails.count
                  row.merge(contacts:)
                else
                  row.merge(contacts: [])
                end
      new_row.except(:contact_name, :email)
    end

    def convert_html_fields_to_text(row)
      row.transform_values { |v| v.is_a?(String) ? Capybara.string(v).text : v }
    end

    def convert_float_fields_to_int(row)
      row.transform_values { |v| v.is_a?(Float) ? v.to_i : v }
    end

    def strip_punctuation_from_postcode(row)
      row.merge(postcode: row[:postcode].gsub(/[^\w\s]/, ''))
    end

    def strip_keys_with_null_or_empty_values(row)
      row.reject { |_, v| v.nil? || v == '' }.to_h
    end

    HEADER_MAP = {
      'Supplier Name' => :supplier_name,
      'Branch Name/No.' => :branch_name,
      'Branch Contact name' => :contact_name,
      'Address 1' => :address_1,
      'Address 2' => :address_2,
      'Town' => :town,
      'County' => :county,
      'Post Code' => :postcode,
      'Branch Contact Name Email Address' => :email,
      'Branch Telephone Number' => :telephone,
      'Region' => :region,
    }.freeze
  end
end
