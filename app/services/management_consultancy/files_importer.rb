class ManagementConsultancy::FilesImporter < FilesImporter
  def initialize(mc_upload)
    import_module = if Marketplace.mcf3_live?
                      ManagementConsultancy
                    else
                      ManagementConsultancy::Legacy
                    end

    super(mc_upload, import_module, ManagementConsultancy)
  end
end
