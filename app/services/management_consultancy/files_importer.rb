class ManagementConsultancy::FilesImporter < FilesImporter
  def initialize(mc_upload)
    import_module = ManagementConsultancy

    super(mc_upload, import_module, ManagementConsultancy)
  end
end
