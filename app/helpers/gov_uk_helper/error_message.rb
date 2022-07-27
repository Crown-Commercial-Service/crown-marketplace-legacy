module GovUKHelper::ErrorMessage
  def govuk_error_message(model, attribute)
    tag.p(id: "#{attribute}-error", class: 'govuk-error-message') do
      capture do
        concat(tag.span('Error:', class: 'govuk-visually-hidden'))
        concat(model.errors[attribute].first)
      end
    end
  end
end
