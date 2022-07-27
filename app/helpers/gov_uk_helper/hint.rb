module GovUKHelper::Hint
  def govuk_hint(*attributes, **hint_options)
    text = hint_options.delete(:text)

    tag.div(text, class: 'govuk-hint', id: hint_id(attributes), **hint_options)
  end

  def hint_id(*attributes)
    (attributes + ['hint']).join('_')
  end
end
