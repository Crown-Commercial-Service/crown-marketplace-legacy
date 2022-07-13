module GovUKHelper::ErrorMessage
  def govuk_error_message(model, attribute)
    tag.p(model.errors[attribute].first, id: "#{attribute}-error", class: 'govuk-error-message')
  end
end
