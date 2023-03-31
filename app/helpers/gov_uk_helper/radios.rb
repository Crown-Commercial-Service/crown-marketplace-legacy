module GovUKHelper::Radios
  def govuk_radios(form, model, attribute, govuk_radios_options, &)
    govuk_form_group(model, attribute) do |error_message|
      govuk_radios_options[:fieldset][:attributes] = if error_message
                                                       { aria: { describedby: "#{attribute}-error" } }
                                                     elsif govuk_radios_options[:hint]
                                                       { aria: { describedby: hint_id([attribute]) } }
                                                     else
                                                       {}
                                                     end

      govuk_fieldset(govuk_radios_options[:fieldset]) do
        concat(govuk_hint(attribute, **govuk_radios_options[:hint])) if govuk_radios_options[:hint]
        concat(error_message)
        concat(tag.div(class: "govuk-radios #{govuk_radios_options[:classes]}", data: { module: 'govuk-radios' }) do
          capture do
            govuk_radios_options[:items].each { |radio_item| concat(govuk_radio_item(form, attribute, radio_item, &)) }
          end
        end)
      end
    end
  end

  private

  def govuk_radio_item(form, attribute, radio_item, &)
    aria_options = if radio_item[:hint]
                     {
                       aria: {
                         describedby: hint_id(attribute, radio_item[:value])
                       }
                     }
                   else
                     {}
                   end

    tag.div(class: 'govuk-radios__item') do
      capture do
        concat(form.radio_button(attribute, radio_item[:value], checked: radio_item[:checked], class: 'govuk-radios__input', **aria_options))
        concat(form.label(attribute, radio_item[:label][:text], value: radio_item[:value], class: "govuk-label govuk-radios__label #{radio_item[:label][:classes]}"))
        govuk_radio_hint(attribute, radio_item, &)
      end
    end
  end

  def govuk_radio_hint(attribute, radio_item)
    return unless radio_item[:hint] || block_given?

    concat(tag.div(class: 'govuk-hint govuk-radios__hint', id: hint_id(attribute, radio_item[:value])) do
      if block_given?
        yield(radio_item[:value])
      else
        radio_item[:hint]
      end
    end)
  end
end
