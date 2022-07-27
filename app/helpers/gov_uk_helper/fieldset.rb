module GovUKHelper::Fieldset
  def govuk_fieldset(govuk_fieldset_options)
    tag.fieldset(class: 'govuk-fieldset', **govuk_fieldset_options[:attributes]) do
      capture do
        concat(govuk_legend(govuk_fieldset_options[:legend]))
        yield
      end
    end
  end

  private

  def govuk_legend(govuk_legend_options)
    tag.legend(class: "govuk-fieldset__legend #{govuk_legend_options[:classes]}") do
      if govuk_legend_options[:page_heading?]
        tag.h1(govuk_legend_options[:text], class: 'govuk-fieldset__heading')
      else
        govuk_legend_options[:text]
      end
    end
  end
end
