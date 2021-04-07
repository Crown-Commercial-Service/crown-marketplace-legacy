# rubocop:disable Metrics/ModuleLength
module ApplicationHelper
  include GovUKHelper
  include HeaderNavigationLinksHelper

  ADMIN_CONTROLLERS = ['supply_teachers/admin', 'management_consultancy/admin', 'legal_services/admin'].freeze
  PLATFORM_LANDINGPAGES = ['', 'legal_services/home', 'supply_teachers/home', 'management_consultancy/home'].freeze

  def miles_to_metres(miles)
    DistanceConverter.miles_to_metres(miles)
  end

  def metres_to_miles(metres)
    DistanceConverter.metres_to_miles(metres)
  end

  def feedback_email_link
    return link_to(t('common.feedback'), Marketplace.supply_teachers_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link') if controller.class.try(:module_parent_name) == 'SupplyTeachers'

    return link_to(t('common.feedback'), 'https://www.smartsurvey.co.uk/s/BGBL4/', target: '_blank', rel: 'noopener', class: 'govuk-link') if controller.class.try(:module_parent_name) == 'LegalServices'

    link_to(t('common.feedback'), 'https://www.smartsurvey.co.uk/s/MIIJB/', target: '_blank', rel: 'noopener', class: 'govuk-link')
  end

  def support_email_link(label)
    govuk_email_link(Marketplace.support_email_address, label, css_class: 'govuk-link ga-support-mailto')
  end

  def footer_email_link(label)
    mail_to(Marketplace.support_email_address, Marketplace.support_email_address, class: 'govuk-link ga-support-mailto', 'aria-label': label)
  end

  def dfe_account_request_url
    'https://ccsheretohelp.uk/contact/?type=ST18/19'
  end

  def support_telephone_number
    Marketplace.support_telephone_number
  end

  def govuk_email_link(email_address, aria_label, css_class: 'govuk-link')
    mail_to(email_address, t('layouts.application.feedback'), class: css_class, 'aria-label': aria_label)
  end

  def govuk_form_group_with_optional_error(journey, *attributes, &block)
    attributes_with_errors = attributes.select { |a| journey.errors[a].any? }

    css_classes = ['govuk-form-group']
    css_classes += ['govuk-form-group--error'] if attributes_with_errors.any?

    tag.div(class: css_classes, &block)
  end

  def govuk_fieldset_with_optional_error(journey, attribute, &block)
    attribute_has_errors = journey.errors[attribute].any?

    options = { class: 'govuk-fieldset' }
    options[:aria] = { describedby: error_id(attribute) } if attribute_has_errors

    tag.fieldset(options, &block)
  end

  def property_name(section_name, attributes)
    return "#{section_name}_#{attributes.is_a?(Array) ? attributes.last : attributes}" unless section_name.nil?

    (attributes.is_a?(Array) ? attributes.last : attributes).to_s
  end

  def display_errors(journey, *attributes)
    safe_join(attributes.map { |a| display_error(journey, a) })
  end

  def display_error(journey, attribute, margin = true, id_prefix = '')
    error = journey.errors[attribute].first
    return if error.blank?

    tag.span(id: "#{id_prefix}#{error_id(attribute)}", class: "govuk-error-message #{'govuk-!-margin-top-3' if margin}") do
      error.to_s
    end
  end

  ERROR_TYPES = {
    too_long: 'maxlength',
    too_short: 'minlength',
    blank: 'required',
    inclusion: 'required',
    after: 'max',
    greater_than: 'min',
    greater_than_or_equal_to: 'min',
    before: 'min',
    less_than: 'max',
    less_than_or_equal_to: 'max',
    not_a_date: 'pattern',
    not_a_number: 'number',
    not_an_integer: 'number'
  }.freeze

  def get_client_side_error_type_from_errors(errors, attribute)
    return ERROR_TYPES[errors.details[attribute].first[:error]] if ERROR_TYPES.key?(errors.details[attribute].try(:first)[:error])

    errors.details[attribute].first[:error].to_sym unless ERROR_TYPES.key?(errors.details[attribute].first[:error])
  end

  def css_classes_for_input(journey, attribute, extra_classes = [])
    error = journey.errors[attribute].first

    css_classes = ['govuk-input'] + extra_classes
    css_classes += ['govuk-input--error'] if error.present?
    css_classes
  end

  def error_id(attribute)
    "#{attribute}-error"
  end

  def page_title
    title = %i[page_title_prefix page_title page_section].map do |title_bit|
      content_for(title_bit)
    end
    title += [t('layouts.application.title')]
    title.reject(&:blank?).map(&:strip).join(': ')
  end

  def add_optional_error_prefix_to_page_title(errors)
    content_for(:page_title_prefix) { t('layouts.application.error_prefix') } unless errors.empty?
  end

  def hidden_fields_for_previous_steps_and_responses(journey)
    html = ActiveSupport::SafeBuffer.new

    journey.previous_questions_and_answers.each do |(key, value)|
      if value.is_a? Array
        value.each do |v|
          html += hidden_field_tag("#{key}[]", v, id: nil)
        end
      else
        html += hidden_field_tag(key, value)
      end
    end
    html
  end

  def service_header_banner
    if service_name_param && lookup_context.template_exists?("#{service_name_param}/_header-banner")
      render partial: "#{service_name_param}/header-banner"
    elsif service_name_param&.include? 'admin'
      render partial: 'layouts/admin/header-banner'
    else
      render partial: 'layouts/header-banner'
    end
  end

  def landing_or_admin_page
    (PLATFORM_LANDINGPAGES.include?(controller.class.controller_path) && controller.action_name == 'index') || controller.action_name == 'landing_page' || ADMIN_CONTROLLERS.include?(controller.class.module_parent_name.try(:underscore))
  end

  def passwords_page
    controller.controller_name == 'passwords'
  end

  def cookies_page
    controller.action_name == 'cookies'
  end

  def not_permitted_page
    controller.action_name == 'not_permitted'
  end

  def format_date(date_object)
    date_object&.in_time_zone('London')&.strftime '%e %B %Y'
  end

  def format_date_time(date_object)
    date_object&.in_time_zone('London')&.strftime '%e %B %Y, %l:%M%P'
  end

  def format_date_time_day(date_object)
    date_object&.in_time_zone('London')&.strftime '%e %B %Y, %l:%M%P'
  end

  def format_money(cost, precision = 2)
    number_to_currency(cost, precision: precision, unit: '£')
  end

  def service_name_param
    @service_name_param ||= params[:service].nil? ? request&.controller_class&.module_parent_name&.underscore : params[:service]
  end

  def cookies_path
    @cookies_path ||=
      case current_service
      when :legal_services
        legal_services_cookies_path(service: service_name_param)
      when :management_consultancy
        management_consultancy_cookies_path(service: service_name_param)
      when :supply_teachers
        supply_teachers_cookies_path(service: service_name_param)
      end
  end

  def accessibility_statement_path
    case current_service
    when :legal_services
      legal_services_accessibility_statement_path(service: service_name_param)
    when :management_consultancy
      management_consultancy_accessibility_statement_path(service: service_name_param)
    when :supply_teachers
      supply_teachers_accessibility_statement_path(service: service_name_param)
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity,  Metrics/PerceivedComplexity
  def current_service
    @current_service ||= if service_name_param&.include? 'legal_services'
                           :legal_services
                         elsif service_name_param&.include? 'management_consultancy'
                           :management_consultancy
                         elsif service_name_param&.include? 'supply_teachers'
                           :supply_teachers
                         end
  end
  # rubocop:enable Metrics/CyclomaticComplexity,  Metrics/PerceivedComplexity
end
# rubocop:enable Metrics/ModuleLength
