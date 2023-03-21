module SupplyTeachers
  class DataImport::MergeData
    include SupplyTeachers::DataImport::Helper

    attr_accessor :output, :errors

    def initialize(current_data, supplier_name_key, destination_key, primary, secondary)
      @current_data = current_data
      @supplier_name_key = supplier_name_key
      @destination_key = destination_key
      @primary = primary
      @secondary = secondary
      @errors = []
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def merge_data
      aliases = Hash.new { |_, k| k }
      uuid_lookup = {}

      read_csv(@current_data.supplier_lookup) do |alias_rows|
        alias_rows.each do |row|
          aliased_supplier_name = row[@supplier_name_key]
          supplier_name = row[@destination_key || 'supplier_name']

          aliases[aliased_supplier_name] = supplier_name
          uuid_lookup[supplier_name] = row['supplier_id']
        end
      end

      augmentations = @secondary.to_h do |item|
        secondary_key = item.delete(MERGE_KEY)
        [aliases[secondary_key], item]
      end

      merged = @primary.map do |primary_item|
        primary_key = primary_item.fetch(MERGE_KEY)
        key = aliases[primary_key]

        if augmentations.key?(key)
          secondary_item = augmentations.delete(key)
          primary_item.deep_merge(secondary_item).merge(supplier_id: uuid_lookup[primary_key])
        else
          primary_item
        end
      end

      augmentations.each do |k, item|
        supplier_id = uuid_lookup[k]
        if supplier_id
          merged << item.merge(supplier_id: supplier_id, supplier_name: k)
        else
          @errors << "'#{@supplier_name_key.capitalize}' cannot be found for the following supplier: #{k}."
        end
      end

      @output = merged
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    MERGE_KEY = :supplier_name
  end
end
