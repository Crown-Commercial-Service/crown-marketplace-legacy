module GovUKHelper::Checkboxes
  def govuk_checkboxes(form, model, attribute, govuk_checkboxes_options)
    govuk_form_group(model, attribute) do |error_message|
      govuk_checkboxes_options[:fieldset][:attributes] = if error_message
                                                           { aria: { describedby: "#{attribute}-error" } }
                                                         elsif govuk_checkboxes_options[:hint]
                                                           { aria: { describedby: hint_id([attribute]) } }
                                                         else
                                                           {}
                                                         end

      govuk_fieldset(govuk_checkboxes_options[:fieldset]) do
        concat(govuk_hint(attribute, **govuk_checkboxes_options[:hint])) if govuk_checkboxes_options[:hint]
        concat(error_message)
        concat(govuk_checkbox_items(form, attribute, govuk_checkboxes_options))
      end
    end
  end

  def govuk_checkbox_items(form, attribute, govuk_checkboxes_options)
    tag.div(class: "govuk-checkboxes #{govuk_checkboxes_options[:classes]}", data: { module: 'govuk-checkboxes' }) do
      capture do
        govuk_checkboxes_options[:items].each do |checkbox_item|
          concat(
            if checkbox_item[:divider]
              govuk_checkbox_divider(checkbox_item)
            else
              govuk_checkbox_item(form, attribute, checkbox_item)
            end
          )
        end
      end
    end
  end

  def govuk_checkbox_item(form, attribute, checkbox_item)
    aria_options = if checkbox_item[:hint]
                     {
                       aria: {
                         describedby: hint_id(attribute, checkbox_item[:value])
                       }
                     }
                   else
                     {}
                   end

    tag.div(class: 'govuk-checkboxes__item') do
      capture do
        concat(check_box_tag("#{attribute}[]", checkbox_item[:value], checkbox_item[:checked], class: 'govuk-checkboxes__input', id: "#{attribute}_#{checkbox_item[:value].downcase.gsub('.', '_')}", **aria_options))
        concat(form.label(attribute, checkbox_item[:text], value: checkbox_item[:value], class: 'govuk-label govuk-checkboxes__label'))
        concat(tag.div(checkbox_item[:hint], class: 'govuk-hint govuk-checkboxes__hint', id: hint_id(attribute, checkbox_item[:value]))) if checkbox_item[:hint]
      end
    end
  end

  def govuk_checkbox_divider(checkbox_item)
    tag.div(checkbox_item[:divider], class: 'govuk-checkboxes__divider')
  end
end
