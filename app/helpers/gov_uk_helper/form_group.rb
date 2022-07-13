module GovUKHelper::FormGroup
  def govuk_form_group(model, attribute)
    govuk_form_group_classes = ['govuk-form-group']
    any_errors = model.errors.include? attribute
    govuk_form_group_classes += ['govuk-form-group--error'] if any_errors

    tag.div(class: govuk_form_group_classes, id: "#{attribute}-form-group") do
      yield((govuk_error_message(model, attribute) if any_errors))
    end
  end
end
