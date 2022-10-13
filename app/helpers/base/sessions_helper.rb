module Base::SessionsHelper
  def local_header_text
    @local_header_text ||= HEADER_TEXT[params[:service]]
  end

  HEADER_TEXT = {
    'management_consultancy' => I18n.t('base.sessions.new.heading.management_consultancy.buyer'),
    'management_consultancy/admin' => I18n.t('base.sessions.new.heading.management_consultancy.admin'),
    'legal_services' => I18n.t('base.sessions.new.heading.legal_services.buyer'),
    'legal_services/admin' => I18n.t('base.sessions.new.heading.legal_services.admin'),
    'supply_teachers' => I18n.t('base.sessions.new.heading.supply_teachers.buyer'),
    'supply_teachers/admin' => I18n.t('base.sessions.new.heading.supply_teachers.admin')
  }.freeze
end
