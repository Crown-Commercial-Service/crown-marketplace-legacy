module LegalServices::SuppliersHelper
  def full_lot_description(lot_number, description)
    "Lot #{lot_number} - #{description}"
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

  def positions
    %w[managing senior solicitor junior trainee]
  end

  def display_rate(position, time)
    number_to_currency(@rate_card[position][time] / 100.0, precision: 2)
  end
end
