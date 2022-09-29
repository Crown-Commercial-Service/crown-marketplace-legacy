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
    return link_to(t('common.feedback'), Marketplace.st_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link') if params[:service].to_s.starts_with? 'supply_teachers'

    return link_to(t('common.feedback'), Marketplace.ls_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link') if params[:service].to_s.starts_with? 'legal_services'

    link_to(t('common.feedback'), Marketplace.mc_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link')
  end

  def dfe_account_request_url
    'https://ccsheretohelp.uk/contact/?type=ST18/19'
  end

  def support_telephone_number
    Marketplace.support_telephone_number
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

    tag.fieldset(**options, &block)
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

  def landing_or_admin_page
    (PLATFORM_LANDINGPAGES.include?(controller.class.controller_path) && controller.action_name == 'index') || controller.action_name == 'landing_page' || ADMIN_CONTROLLERS.include?(controller.class.module_parent_name.try(:underscore))
  end

  def passwords_page
    controller.controller_name == 'passwords'
  end

  def cookies_page
    controller.action_name == 'cookie_policy' || controller.action_name == 'cookie_settings'
  end

  def not_permitted_page
    controller.action_name == 'not_permitted'
  end

  def format_date(date_object)
    date_object&.in_time_zone('London')&.strftime '%-d %B %Y'
  end

  def format_date_time(date_object)
    date_object&.in_time_zone('London')&.strftime '%e %B %Y, %l:%M%P'
  end

  def format_money(cost, precision = 2)
    number_to_currency(cost, precision: precision, unit: '£')
  end

  def cookie_policy_path
    "#{service_path_base}/cookie-policy"
  end

  def cookie_settings_path
    "#{service_path_base}/cookie-settings"
  end

  def accessibility_statement_path
    "#{service_path_base}/accessibility-statement"
  end

  def supply_teachers_accessibility_statement_links
    ['sign-in', 'forgot-password', 'fixed-term-results', 'master-vendors', 'temp-to-perm-calculator?looking_for=calculate_temp_to_perm_fee', 'branches/3d-recruit'].map { |link| "https://marketplace.service.crowncommercial.gov.uk/supply-teachers/#{link}" }
  end

  def govuk_tag_with_text(colour, text)
    extra_classes = {
      grey: 'govuk-tag--grey',
      blue: 'govuk-tag',
      red: 'govuk-tag--red'
    }

    tag.strong(text, class: ['govuk-tag'] << extra_classes[colour])
  end

  def link_to_public_file_for_download(filename, file_type, text, show_doc_image, **html_options)
    link_to_file_for_download("/#{filename}?format=#{file_type}", file_type, text, show_doc_image, **html_options)
  end

  def link_to_generated_file_for_download(filename, file_type, text, show_doc_image, **html_options)
    link_to_file_for_download("#{filename}&format=#{file_type}", file_type, text, show_doc_image, **html_options)
  end

  def link_to_file_for_download(file_link, file_type, text, show_doc_image, **html_options)
    link_to(file_link, class: ('supplier-record__file-download' if show_doc_image).to_s, type: t("common.type_#{file_type}"), download: '', **html_options) do
      capture do
        concat(text)
        concat(tag.span(t("common.title_#{file_type}_html"), class: 'govuk-visually-hidden')) if show_doc_image
      end
    end
  end

  def get_error_details(service, error, details)
    return t("#{service}.admin.uploads.failed.error_details.#{error}") unless details

    t("#{service}.admin.uploads.failed.error_details.#{error}_html", list: details.is_a?(Array) ? details_to_list(details) : details)
  end

  def details_to_list(details)
    tag.ul class: 'govuk-list govuk-list--bullet' do
      details.each do |detail|
        concat(tag.li(detail))
      end
    end
  end

  def url_formatter(url)
    u = URI.parse(url)

    return url if %w[http https].include?(u.scheme)

    "http://#{url}"
  end

  def contact_link(link_text)
    # TODO: add param to URL for contact form

    service_name = case params[:service]
                   when 'management_consultancy', 'management_consultancy/admin'
                     'Management Consultancy'
                   when 'legal_services', 'legal_services/admin'
                     'Legal Services'
                   when 'supply_teachers', 'supply_teachers/admin', 'auth'
                     'Supply Teachers'
                   end

    uri = URI(Marketplace.support_form_link)
    uri.query = { service: service_name }.to_query if service_name

    link_to(link_text, uri.to_s, target: :blank, class: 'govuk-link')
  end

  def checked?(actual, expected)
    actual == expected
  end

  def cookie_preferences_settings
    @cookie_preferences_settings ||= begin
      current_cookie_preferences = JSON.parse(cookies[Marketplace.cookie_settings_name] || '{}')

      current_cookie_preferences.empty? ? Marketplace.default_cookie_options : current_cookie_preferences
    end
  end

  def admin_upload_file(upload, attachment, service, framework)
    "#{rails_blob_path(attachment, disposition: 'attachment', key: "#{service}_#{framework}_upload_id".to_sym, value: upload.id)}&format=#{get_file_extension(attachment)}"
  end

  def get_file_extension(file)
    file.filename.extension_without_delimiter.to_sym
  end
end
# rubocop:enable Metrics/ModuleLength
