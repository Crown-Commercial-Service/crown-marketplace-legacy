module ManagementConsultancy::SuppliersHelper
  def mc_lot_key(lot)
    framework = lot.split('.')[0].downcase
    lot_number = lot.split('.')[1]
    "#{framework}.lot_#{lot_number}"
  end

  def url_formatter(url)
    u = URI.parse(url)

    return url if %w[http https].include?(u.scheme)

    "http://#{url}"
  end

  def eoi_document_link(lot)
    if lot.starts_with? 'MCF1'
      t('management_consultancy.suppliers.download.expression_of_interest_template_link_1')
    elsif lot.starts_with? 'MCF2'
      t('management_consultancy.suppliers.download.expression_of_interest_template_link_2')
    elsif lot.starts_with? 'MCF3'
      t('management_consultancy.suppliers.download.expression_of_interest_template_link_3')
    end
  end
end
