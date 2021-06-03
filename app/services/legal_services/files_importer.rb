class LegalServices::FilesImporter < FilesImporter
  def initialize(ls_upload)
    super(ls_upload, LegalServices)
  end
end
