module HeaderNavigationLinksHelper
  def default_navigation_links(home_path = supply_teachers_path, sign_out_path = supply_teachers_destroy_user_session_path)
    navigation_links = []

    navigation_links << { link_text: t('header_navigation_links_helper.back_to_start'), link_url: home_path }
    navigation_links << sign_out_link(sign_out_path)

    navigation_links.compact
  end

  def default_admin_navigation_links
    navigation_links = []

    if %w[supply-teachers legal-services management-consultancy].include? request.original_fullpath.split('/')[1]
      navigation_links << sign_out_link("#{request.original_fullpath.split('/')[1].gsub('-', '_')}_admin_destroy_user_session_path")
    else
      navigation_links << { link_text: t('header_navigation_links_helper.back_to_start'), link_url: supply_teachers_admin_uploads_path }
      navigation_links << sign_out_link(supply_teachers_destroy_user_session_path)
    end

    navigation_links.compact
  end

  def sign_out_link(sign_out_path)
    { link_text: t('header_navigation_links_helper.sign_out'), link_url: sign_out_path, options: { method: :delete } } if user_signed_in?
  end
end
