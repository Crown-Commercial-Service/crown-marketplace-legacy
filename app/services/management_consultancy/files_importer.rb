class ManagementConsultancy::FilesImporter
  IMPORT_PROCESS_ORDER = %i[check_files process_files check_processed_data publish_data].freeze

  def initialize(mc_upload)
    @mc_upload = mc_upload
  end

  def import_data
    IMPORT_PROCESS_ORDER.each do |import_process|
      @mc_upload.send("#{import_process}!")
      send(import_process)
      break if @errors.any?
    end

    if @errors.any?
      @mc_upload.update(import_errors: @errors)
      @mc_upload.fail!
    else
      @mc_upload.publish!
    end
  rescue StandardError => e
    @mc_upload.update(import_errors: [{ error: 'upload_failed' }])
    @mc_upload.fail!

    Rollbar.log('error', e)
  end

  private

  def check_files
    @errors = if Marketplace.mcf3_live?
                ManagementConsultancy::FilesChecker.new(@mc_upload).check_files
              else
                ManagementConsultancy::Legacy::FilesChecker.new(@mc_upload).check_files
              end
  rescue StandardError => e
    Rollbar.log('error', e)
    @errors = [{ error: 'file_check_failed' }]
  end

  def process_files
    @supplier_data = if Marketplace.mcf3_live?
                       ManagementConsultancy::FilesProcessor.new(@mc_upload).process_files
                     else
                       ManagementConsultancy::Legacy::FilesProcessor.new(@mc_upload).process_files
                     end
  rescue StandardError => e
    Rollbar.log('error', e)
    @errors << { error: 'file_process_failed' }
  end

  def check_processed_data
    supplier_missing_lots = @supplier_data.select { |supplier| supplier['lots'].blank? }
    supplier_missing_rate_cards = @supplier_data.select { |supplier| supplier['rate_cards'].blank? }

    @errors << { error: 'supplier_missing_lots', details: supplier_missing_lots.map { |supplier| supplier['name'] } } if supplier_missing_lots.any?
    @errors << { error: 'supplier_missing_rate_cards', details: supplier_missing_rate_cards.map { |supplier| supplier['name'] } } if supplier_missing_rate_cards.any?
  end

  def publish_data
    ManagementConsultancy::Upload.upload!(@supplier_data)
  rescue StandardError => e
    Rollbar.log('error', e)
    @errors << { error: 'file_publish_failed' }
  end
end
