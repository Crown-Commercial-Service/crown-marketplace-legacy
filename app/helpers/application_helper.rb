# rubocop:disable Metrics/ModuleLength
module ApplicationHelper
  include CCS::FrontendHelpers
  include HeaderNavigationLinksHelper

  ADMIN_CONTROLLERS = ['supply_teachers/admin', 'management_consultancy/admin', 'legal_services/admin', 'legal_panel_for_government/admin'].freeze
  PLATFORM_LANDINGPAGES = ['', 'legal_panel_for_government/home', 'legal_services/home', 'supply_teachers/home', 'management_consultancy/home'].freeze

  delegate :miles_to_metres, to: :DistanceConverter

  delegate :metres_to_miles, to: :DistanceConverter

  def feedback_email_link
    return link_to(t('common.feedback'), Marketplace.st_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link') if params[:service].to_s.starts_with? 'supply_teachers'

    return link_to(t('common.feedback'), Marketplace.ls_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link') if params[:service].to_s.starts_with? 'legal_services'

    return link_to(t('common.feedback'), Marketplace.lpg_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link') if params[:service].to_s.starts_with? 'legal_panel_for_government'

    link_to(t('common.feedback'), Marketplace.mc_survey_link, target: '_blank', rel: 'noopener', class: 'govuk-link')
  end

  def dfe_account_request_url
    'https://ccsheretohelp.uk/contact/?type=ST18/19'
  end

  delegate :support_telephone_number, to: :Marketplace

  def error_id(attribute)
    "#{attribute}-error"
  end

  def page_title
    title = %i[page_title_prefix page_title page_section].map do |title_bit|
      content_for(title_bit)
    end
    title += [t('layouts.application.title')]
    title.compact_blank.map(&:strip).join(': ')
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

  def link_to_public_file_for_download(filename, file_type, text, show_doc_image, **)
    link_to_file_for_download("/#{filename}?format=#{file_type}", file_type, text, show_doc_image, **)
  end

  def link_to_generated_file_for_download(filename, file_type, text, show_doc_image, **)
    link_to_file_for_download("#{filename}&format=#{file_type}", file_type, text, show_doc_image, **)
  end

  def link_to_file_for_download(file_link, file_type, text, show_doc_image, **html_options)
    html_options[:type] = t("common.type_#{file_type}")
    html_options[:download] = ''

    if show_doc_image
      html_options[:class] = "supplier-record__file-download #{html_options.delete(:classes)}".rstrip

      link_to(file_link, **html_options) do
        capture do
          concat(text)
          concat(tag.span(t("common.title_#{file_type}_html"), class: 'govuk-visually-hidden'))
        end
      end
    else
      govuk_button(text, href: file_link, classes: html_options.delete(:classes), attributes: html_options)
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

  def contact_us_link
    service_name = case params[:service]
                   when 'management_consultancy', 'management_consultancy/admin'
                     'Management Consultancy'
                   when 'legal_services', 'legal_services/admin'
                     'Legal Services'
                   when 'legal_panel_for_government', 'legal_panel_for_government/admin'
                     'Legal Panel for Government'
                   when 'supply_teachers', 'supply_teachers/admin', 'auth'
                     'Supply Teachers'
                   end

    uri = URI(Marketplace.support_form_link)
    uri.query = { service: service_name }.to_query if service_name

    uri.to_s
  end

  def contact_link(link_text)
    link_to(link_text, contact_us_link, target: :blank, class: 'govuk-link', rel: 'noreferrer noopener')
  end

  def checked?(actual, expected)
    actual == expected
  end

  def cookie_preferences_settings
    @cookie_preferences_settings ||= begin
      current_cookie_preferences = JSON.parse(cookies[Marketplace.cookie_settings_name] || '{}')

      !current_cookie_preferences.is_a?(Hash) || current_cookie_preferences.empty? ? Marketplace.default_cookie_options : current_cookie_preferences
    end
  end

  def admin_upload_file(upload, attachment, service, framework)
    "#{rails_blob_path(attachment, disposition: 'attachment', key: :"#{service}_#{framework}_upload_id", value: upload.id)}&format=#{get_file_extension(attachment)}"
  end

  def get_file_extension(file)
    file.filename.extension_without_delimiter.to_sym
  end

  # rubocop:disable Metrics/AbcSize
  def pagination_params(paginator)
    template = paginator.instance_variable_get(:@template)
    options = paginator.instance_variable_get(:@options)
    current_page = options[:current_page]

    parameters = {}

    parameters[:pagination_previous] = { href: Kaminari::Helpers::PrevPage.new(template, **options).url } unless current_page.first?

    last_page_gap = false

    parameters[:pagination_items] = paginator.each_page.map do |page|
      if page.display_tag?
        last_page_gap = false

        {
          type: :number,
          href: Kaminari::Helpers::Page.new(template, **options, page:).url,
          number: page.number,
          current: page.current?
        }
      elsif !last_page_gap
        last_page_gap = true

        {
          ellipsis: true
        }
      end
    end.compact

    parameters[:pagination_next] = { href: Kaminari::Helpers::NextPage.new(template, **options).url } if !current_page.out_of_range? && !current_page.last?

    parameters
  end
  # rubocop:enable Metrics/AbcSize

  def password_strength(password_id)
    ccs_password_strength(
      password_id,
      [
        {
          type: :length,
          value: 8,
          text: I18n.t('common.passeight')
        },
        {
          type: :symbol,
          value: '#?!@£$%^&*-',
          text: I18n.t('common.passsymbol')
        },
        {
          type: :uppercase,
          text: I18n.t('common.passcap')
        },
        {
          type: :number,
          text: I18n.t('common.passnum')
        }
      ],
      classes: 'govuk-!-margin-left-2'
    )
  end

  GOVUK_DATE_ITEMS = [
    {
      name: 'dd',
      input: {
        classes: 'govuk-input--width-2'
      },
      label: {
        text: I18n.t('date.day')
      }
    },
    {
      name: 'mm',
      input: {
        classes: 'govuk-input--width-2'
      },
      label: {
        text: I18n.t('date.month')
      }
    },
    {
      name: 'yyyy',
      input: {
        classes: 'govuk-input--width-4'
      },
      label: {
        text: I18n.t('date.year')
      }
    }
  ].freeze
end
# rubocop:enable Metrics/ModuleLength
