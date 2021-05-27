class LegalServices::FilesImporter
  IMPORT_PROCESS_ORDER = %i[check_files process_files check_processed_data publish_data].freeze

  def initialize(ls_upload)
    @ls_upload = ls_upload
  end

  def import_data
    IMPORT_PROCESS_ORDER.each do |import_process|
      @ls_upload.send("#{import_process}!")
      send(import_process)
      break if @errors.any?
    end

    if @errors.any?
      @ls_upload.update(import_errors: @errors)
      @ls_upload.fail!
    else
      @ls_upload.publish!
    end
  rescue StandardError => e
    @ls_upload.update(import_errors: [{ error: 'upload_failed' }])
    @ls_upload.fail!

    Rollbar.log('error', e)
  end

  private

  def check_files
    @errors = LegalServices::FilesChecker.new(@ls_upload).check_files
  rescue StandardError => e
    Rollbar.log('error', e)
    @errors = [{ error: 'file_check_failed' }]
  end

  def process_files
    @supplier_data = LegalServices::FilesProcessor.new(@ls_upload).process_files
  rescue StandardError => e
    Rollbar.log('error', e)
    @errors << { error: 'file_process_failed' }
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def check_processed_data
    supplier_missing_lots = @supplier_data.select { |supplier| supplier['lot_1_services'].empty? && supplier['lots'].empty? }
    supplier_missing_rate_cards = @supplier_data.select { |supplier| supplier['rate_cards'].empty? }

    @errors << { error: 'supplier_missing_lots', details: supplier_missing_lots.map { |supplier| supplier['name'] } } if supplier_missing_lots.any?
    @errors << { error: 'supplier_missing_rate_cards', details: supplier_missing_rate_cards.map { |supplier| supplier['name'] } } if supplier_missing_rate_cards.any?
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def publish_data
    LegalServices::Upload.upload!(@supplier_data)
  rescue StandardError => e
    Rollbar.log('error', e)
    @errors << { error: 'file_publish_failed' }
  end
end
