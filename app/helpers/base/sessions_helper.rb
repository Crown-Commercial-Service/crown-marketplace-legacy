module Base::SessionsHelper
  def local_header_text
    @local_header_text ||= HEADER_TEXT[params[:service]]
  end

  HEADER_TEXT = {
    'management_consultancy' => I18n.t('base.sessions.new.heading.management_consultancy'),
    'legal_services' => I18n.t('base.sessions.new.heading.legal_services')
  }.freeze
end
