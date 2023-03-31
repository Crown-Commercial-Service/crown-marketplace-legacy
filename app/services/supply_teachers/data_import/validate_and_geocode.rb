module SupplyTeachers
  class DataImport::ValidateAndGeocode
    include SupplyTeachers::DataImport::Helper

    attr_reader :suppliers, :errors

    def initialize(current_data, suppliers)
      @current_data = current_data
      @suppliers = suppliers
      @errors = []
      configure_geocode
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def validate_and_geocode
      @suppliers = @suppliers.map do |supplier|
        supplier.tap do |s|
          next unless s[:branches]

          s[:branches] = s[:branches]
                         .map { |b| check_contacts(b) }
                         .map { |b| fix_telephone(b) }
                         .map { |b| normalize_postcode(b) }
                         .map { |b| geocode_branch(b) }
          add_empty_lists(s)
        end
      end

      @suppliers.map do |supplier|
        supplier.tap do |s|
          check_pricing_present(s)
          next unless s[:branches]

          branch_errors, branches = s[:branches].partition { |b| errors?(b) }
          branch_errors.each do |branch|
            next unless supplier_accredited?(supplier[:supplier_name])

            @errors << "#{supplier[:supplier_name]} - #{branch[:branch_name]}: #{branch[:errors].inspect}. Check the branch row in the file 'input/Geographical Data all @suppliers.xlsx'"
          end
          s[:branches] = branches
        end
      end

      @suppliers = @suppliers.sort_by { |s| s[:supplier_name] }

      File.write(geocoder_cache_path, YAML.dump(@geocoder_cache))
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    private

    def configure_geocode
      @geocoder_cache = {}

      if File.exist?(geocoder_cache_path)
        File.open(geocoder_cache_path) do |file|
          @geocoder_cache = YAML.safe_load(file.read)
        end
      else
        FileUtils.mkdir_p(geocoder_cache_path.dirname)
        FileUtils.touch(geocoder_cache_path)
      end

      Geocoder.configure(
        lookup: :google,
        api_key: ENV.fetch('GOOGLE_GEOCODING_API_KEY', nil),
        units: :mi,
        distance: :spherical,
        cache: @geocoder_cache
      )
    end

    def geocode(postcode)
      Geocoder.coordinates(postcode, params: { region: 'uk' })
    end

    def geocoder_cache_path
      @geocoder_cache_path ||= Rails.root.join('storage', 'supply_teachers', 'current_data', '.geocoder-cache.yml')
    end

    def add_error(branch, error)
      branch[:errors] ||= []
      branch[:errors] << error
    end

    def errors?(branch)
      branch[:errors].present?
    end

    def fix_telephone(row)
      telephone = row[:telephone]
      case telephone
      when String
        row.merge(telephone: telephone.gsub(/^#/, ''))
      when Integer
        row.merge(telephone: "0#{telephone}")
      when Float
        row.merge(telephone: "0#{telephone.to_i}")
      else
        add_error(row, "telephone is unexpected type: #{telephone.inspect}")
        row
      end
    end

    def normalize_postcode(row)
      postcode = UKPostcode.parse(row[:postcode])
      if postcode.valid?
        row.merge postcode: postcode.to_s
      else
        add_error(row, "postcode not valid #{row[:postcode]}")
        row
      end
    end

    def geocode_branch(row)
      lat, lon = geocode(row[:postcode])
      if lat && lon
        row.merge(lat:, lon:)
      else
        add_error(row, "Unable to geocode #{row[:postcode]}")
        row
      end
    end

    def check_contacts(row)
      empty_contacts = row[:contacts].blank?
      add_error(row, 'Missing/malformed contacts: amount of contact names and emails don’t match') if empty_contacts
      row
    end
  end
end
