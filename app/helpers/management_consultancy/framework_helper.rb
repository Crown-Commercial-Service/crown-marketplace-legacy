module ManagementConsultancy::FrameworkHelper
  def framework_lot_and_description(number, description)
    framework = number.split('.')[0].gsub('1', '')
    lot_number = number.split('.')[1]

    "#{framework} lot #{lot_number} - #{description}"
  end
end
