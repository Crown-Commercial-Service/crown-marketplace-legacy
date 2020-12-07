module LegalServices::SuppliersHelper
  def full_lot_description(lot_number, description)
    "Lot #{lot_number} - #{description}"
  end

  def url_formatter(url)
    u = URI.parse(url)

    return url if %w[http https].include?(u.scheme)

    "http://#{url}"
  end

  def prospectus_link_a_url?
    URI.parse(prospectus_link)
    true
  rescue StandardError
    false
  end

  def prospectus_link
    @prospectus_link ||= @supplier.send(:"lot_#{params[:lot]}_prospectus_link")
  end
end
