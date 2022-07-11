module SupplyTeachers
  class DataImport
    def initialize(st_upload)
      @st_upload = st_upload
      @current_data = self.class.module_parent::CurrentData.first
      @errors = []
    end

    def import_data
      self.class::IMPORT_PROCESS_ORDER.each { |import_process| send(import_process) }

      @st_upload.files_processing_complete!
    rescue StandardError => e
      @st_upload.update(fail_reason: e)
      @st_upload.fail!
      Rollbar.log('error', e)
    end

    def generate_branches
      branches = self.class::GenerateBranches.new(@current_data)
      branches.generate_branches
      @supplier_branches = branches.supplier_branches
    end

    def generate_pricing
      pricing = self.class::GeneratePricing.new(@current_data)
      pricing.generate_pricing
      @supplier_pricing = pricing.supplier_pricing
      @errors += pricing.errors
    end

    def generate_accreditation
      accreditation = self.class::GenerateAccreditation.new(@current_data)
      accreditation.generate_accreditation
      @supplier_accreditation = accreditation.supplier_accreditation
    end

    def merge_data
      primary_data = @supplier_branches

      merge_data_sets.each do |supplier_name_key, destination_key, secondary_data|
        merge_data_object = SupplyTeachers::DataImport::MergeData.new(@current_data, supplier_name_key, destination_key, primary_data, secondary_data)
        merge_data_object.merge_data
        primary_data = merge_data_object.output
        @errors += merge_data_object.errors
      end

      @data = primary_data
    end

    def exclude_suppliers_without_accreditation
      @data.select! { |supplier| supplier[:accreditation] }
    end

    def add_vendor_contacts
      vendor_contacts = self.class::AddVendorContacts.new(@current_data, @data)
      vendor_contacts.add_vendor_contacts
      @data = vendor_contacts.data_with_vendors
    end

    def validate_and_geocode
      geocodeing = self.class::ValidateAndGeocode.new(@current_data, @data)
      geocodeing.validate_and_geocode
      @data = geocodeing.suppliers
      @errors += geocodeing.errors
    end

    def strip_line_numbers
      json = JSON.pretty_generate(@data)
      hash = JsonPath.for(json).delete('..line_no').to_hash

      temp_file = Tempfile.new('data.json')
      begin
        File.open(temp_file, 'w') do |f|
          f.puts JSON.pretty_generate(hash)
        end
        @st_upload.data.attach(io: File.open(temp_file.path), filename: 'data.json')
      ensure
        temp_file.close
        temp_file.unlink
        @st_upload.save
      end
    end

    def upload_data_and_errors
      @current_data.data.attach @st_upload.data.blob
      @current_data.error = @errors.join("\n")
      @current_data.save!
    end
  end
end
