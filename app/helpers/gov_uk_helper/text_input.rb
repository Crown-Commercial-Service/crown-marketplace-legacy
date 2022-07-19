module GovUKHelper::TextInput
  def govuk_text_input(form, model, attribute, govuk_text_input_options)
    govuk_form_group(model, attribute) do |error_message|
      capture do
        concat(govuk_label(form, attribute, govuk_text_input_options[:label])) if govuk_text_input_options[:label]
        concat(govuk_hint(attribute, **govuk_text_input_options[:hint])) if govuk_text_input_options[:hint]
        concat(error_message)
        concat(govuk_input(form, attribute, error_message.present?, govuk_text_input_options[:input]))
      end
    end
  end

  def govuk_label(form, attribute, label_options = {})
    class_list = ['govuk-label']
    class_list << label_options[:classes] if label_options[:classes]

    label_html = form.label(attribute, label_options[:text], class: class_list, **label_options)

    if label_options[:page_heading?]
      tag.h1(class: 'govuk-fieldset__heading') do
        label_html
      end
    else
      label_html
    end
  end

  def govuk_input(form, attribute, any_errors, input_options = {})
    prefix = input_options.delete(:prefix)
    suffix = input_options.delete(:suffix)

    text_field_html = govuk_text_field(form, attribute, any_errors, **input_options)

    if prefix || suffix
      tag.div(class: 'govuk-input__wrapper') do
        capture do
          concat(tag.div(prefix[:text], class: 'govuk-input__prefix', aria: { hidden: true })) if prefix
          concat(text_field_html)
          concat(tag.div(suffix[:text], class: 'govuk-input__suffix', aria: { hidden: true })) if suffix
        end
      end
    else
      text_field_html
    end
  end

  private

  def govuk_text_field(form, attribute, any_errors, **input_options)
    class_list = ['govuk-input']
    class_list << input_options.delete(:classes) if input_options[:classes]
    class_list << 'govuk-input--error' if any_errors

    if form.is_a? Symbol
      text_field(form, attribute, class: class_list, **input_options)
    else
      form.text_field(attribute, class: class_list, **input_options)
    end
  end
end
