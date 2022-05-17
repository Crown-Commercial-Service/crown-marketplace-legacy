class ManagementConsultancy::RM6187::FilesImporter < FilesImporter
  def initialize(mc_upload)
    import_module = ManagementConsultancy::RM6187

    super(mc_upload, import_module, ManagementConsultancy::RM6187)
  end
end
