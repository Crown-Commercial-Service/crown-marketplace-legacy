class SupplyTeachers::RM3826::DataImport
  IMPORT_PROCESS_ORDER = %i[generate_branches generate_pricing generate_vendor_pricing generate_accreditation merge_data exclude_suppliers_without_accreditation add_vendor_contacts validate_and_geocode strip_line_numbers upload_data_and_errors].freeze

  def initialize(st_upload)
    @st_upload = st_upload
    @current_data = SupplyTeachers::RM3826::Admin::CurrentData.first
    @errors = []
  end

  def import_data
    IMPORT_PROCESS_ORDER.each { |import_process| send(import_process) }

    @st_upload.files_processing_complete!
  rescue StandardError => e
    @st_upload.update(fail_reason: e)
    @st_upload.fail!

    Rollbar.log('error', e)
  end

  def generate_branches
    branches = SupplyTeachers::RM3826::GenerateBranches.new(@current_data)
    branches.generate_branches
    @supplier_branches = branches.supplier_branches
  end

  def generate_pricing
    pricing = SupplyTeachers::RM3826::GeneratePricing.new(@current_data)
    pricing.generate_pricing
    @supplier_pricing = pricing.supplier_pricing
    @errors += pricing.errors
  end

  def generate_vendor_pricing
    vendor_pricing = SupplyTeachers::RM3826::GenerateVendorPricing.new(@current_data)
    vendor_pricing.generate_vendor_pricing
    @supplier_vendor_pricing = vendor_pricing.supplier_vendor_pricing
    @errors += vendor_pricing.errors
  end

  def generate_accreditation
    accreditation = SupplyTeachers::RM3826::GenerateAccreditation.new(@current_data)
    accreditation.generate_accreditation
    @supplier_accreditation = accreditation.supplier_accreditation
  end

  def merge_data
    merge_data_object = SupplyTeachers::RM3826::MergeData.new(@current_data, 'pricing supplier name', 'branches supplier name', @supplier_branches, @supplier_pricing)
    merge_data_object.merge_data
    data_branches_pricing = merge_data_object.output
    @errors += merge_data_object.errors

    merge_data_object = SupplyTeachers::RM3826::MergeData.new(@current_data, 'vendor supplier name', 'branches supplier name', data_branches_pricing, @supplier_vendor_pricing)
    merge_data_object.merge_data
    data_branches_pricing_vendors = merge_data_object.output
    @errors += merge_data_object.errors

    merge_data_object = SupplyTeachers::RM3826::MergeData.new(@current_data, 'accreditation supplier name', 'branches supplier name', data_branches_pricing_vendors, @supplier_accreditation)
    merge_data_object.merge_data
    @data = merge_data_object.output
    @errors += merge_data_object.errors
  end

  def exclude_suppliers_without_accreditation
    @data.select! { |supplier| supplier[:accreditation] }
  end

  def add_vendor_contacts
    vendor_contacts = SupplyTeachers::RM3826::AddVendorContacts.new(@current_data, @data)
    vendor_contacts.add_vendor_contacts
    @data = vendor_contacts.data_with_vendors
  end

  def validate_and_geocode
    geocodeing = SupplyTeachers::RM3826::ValidateAndGeocode.new(@current_data, @data)
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
