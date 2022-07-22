module GovUKHelper::DateInput
  def govuk_date_input(form, model, attribute, govuk_date_input_options)
    govuk_form_group(model, attribute) do |error_message|
      govuk_date_input_options[:fieldset][:attributes] = if error_message
                                                           { aria: { describedby: "#{attribute}-error" } }
                                                         elsif govuk_date_input_options[:hint]
                                                           { aria: { describedby: hint_id([attribute]) } }
                                                         else
                                                           {}
                                                         end

      govuk_fieldset(govuk_date_input_options[:fieldset]) do
        concat(govuk_hint(attribute, **govuk_date_input_options[:hint])) if govuk_date_input_options[:hint]
        concat(error_message)
        concat(tag.div(class: 'govuk-date-input', id: attribute.to_s.gsub('_', '-')) do
          capture do
            %i[day month year].each do |date_part|
              concat(date_input(form, model, attribute, date_part, error_message.present?))
            end
          end
        end)
      end
    end
  end

  private

  def date_input(form, model, attribute, date_part, any_errors)
    full_attribute = "#{attribute}_#{date_part}".to_sym

    tag.div(class: 'govuk-date-input__item') do
      tag.div(class: 'govuk-form-group') do
        capture do
          concat(govuk_label(form, full_attribute, {
                               text: DATE_OPTIONS[date_part][:text],
                               classes: 'govuk-date-input__label'
                             }))
          concat(govuk_input(form, full_attribute, any_errors, {
                               value: model.send(full_attribute),
                               classes: "govuk-date-input__input #{DATE_OPTIONS[date_part][:width]}"
                             }))
        end
      end
    end
  end

  DATE_OPTIONS = {
    day: {
      text: 'Day',
      width: 'govuk-input--width-2'
    },
    month: {
      text: 'Month',
      width: 'govuk-input--width-2'
    },
    year: {
      text: 'Year',
      width: 'govuk-input--width-4'
    }
  }.freeze
end
