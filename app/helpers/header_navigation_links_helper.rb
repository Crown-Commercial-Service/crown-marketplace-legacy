module HeaderNavigationLinksHelper
  def service_navigation_links
    navigation_links = []

    navigation_links << { link_text: t('header_navigation_links_helper.back_to_start'), link_url: service_path_base }
    navigation_links << { link_text: t('header_navigation_links_helper.sign_out'), link_url: "#{service_path_base}/sign-out", options: { method: :delete } } if user_signed_in?

    navigation_links.compact
  end

  def service_name_text
    case params[:service]
    when 'legal_services'
      t('home.index.legal_services_link')
    when 'management_consultancy'
      t('home.index.management_consultancy_link')
    when 'supply_teachers'
      t('home.index.supply_teachers_link')
    else
      t('home.index.admin')
    end
  end
end
