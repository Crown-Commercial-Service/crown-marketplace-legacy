module GovUKHelper::Details
  def govuk_details(summary_text, **options, &)
    govuk_details_classes = ['govuk-details']
    govuk_details_classes << options.delete(:classes) if options[:classes]

    tag.details(class: govuk_details_classes, data: { module: 'govuk-details' }, **options) do
      capture do
        concat(tag.summary(tag.span(summary_text, class: 'govuk-details__summary-text'), class: 'govuk-details__summary'))
        concat(tag.div(class: 'govuk-details__text', &))
      end
    end
  end
end
