module Base::SessionsHelper
  def local_header_text
    @local_header_text ||= begin
      service_name, user_type = params[:service].split('/')

      I18n.t("base.sessions.new.heading.#{service_name}.#{params[:framework].downcase}.#{user_type || 'buyer'}")
    end
  end
end
