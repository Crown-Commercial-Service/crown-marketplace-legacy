module HeaderNavigationLinksHelper
  def service_name_text
    case params[:service]
    when 'legal_services'
      t('home.index.legal_services_link')
    when 'legal_panel_for_government'
      t('home.index.legal_panel_for_government_link')
    when 'management_consultancy'
      t('home.index.management_consultancy_link')
    when 'supply_teachers'
      t('home.index.supply_teachers_link')
    else
      t('home.index.admin')
    end
  end

  def service_authentication_links
    navigation_links = []

    if user_signed_in?
      navigation_links << {
        text: t('header_navigation_links_helper.sign_out'),
        href: "#{service_path_base}/sign-out",
        method: :delete
      }
    else
      if ['legal_services', 'legal_panel_for_government', 'management_consultancy'].include?(params[:service])
        navigation_links << {
          text: t('header_navigation_links_helper.sign_up'),
          href: "#{service_path_base}/sign-up"
        }
      end

      navigation_links << {
        text: t('header_navigation_links_helper.sign_in'),
        href: "#{service_path_base}/#{params[:service] == 'supply_teachers' ? 'gateway' : 'sign-in'}"
      }
    end

    navigation_links
  end

  def service_navigation_links
    if user_signed_in? && params[:service] == 'management_consultancy'
      [
        {
          text: t('header_navigation_links_helper.back_to_start'),
          href: management_consultancy_journey_start_path(framework: params[:framework]),
          active: current_page?(management_consultancy_journey_question_path(framework: params[:framework], slug: 'choose-lot'))
        }
      ]
    else
      [
        {
          text: t('header_navigation_links_helper.back_to_start'),
          href: service_path_base,
          active: current_page?(service_path_base)
        }
      ]
    end
  end
end
