type FormElements = {
  input: string
  outputs: FormElementsOutputs[]
}

type FormElementsOutputs = {
  class: string
  output: ResultOutput
}

type ResultOutput = 'worker_cost' | 'agency_fee' | 'finders_fee'

type Result = {
  error: string
  worker_cost: number
  agency_fee: number
  finders_fee: number
}

const numberToCurrency = (number: number): string => {
  return `£${number.toFixed(2)}`
}

const agencyList: FormElements = {
  input: '.calculator-form__day-rate-input',
  outputs: [
    {
      class: '.supplier-record__worker-cost',
      output: 'worker_cost',
    },
    {
      class: '.supplier-record__agency-fee',
      output: 'agency_fee',
    },
  ],
}

const fixedTermCalculator: FormElements = {
  input: '.calculator-form__annual-salary-input',
  outputs: [
    {
      class: '.supplier-record__finders-fee',
      output: 'finders_fee',
    },
  ],
}

const showErrors = ($calculator: JQuery<HTMLElement>, formElements: FormElements): void => {
  $calculator.addClass('govuk-form-group govuk-form-group--error')
    .find(formElements.input).addClass('govuk-input--error').end()
    .find('.govuk-error-message')
    .removeClass('govuk-visually-hidden')
    .end()

  formElements.outputs.forEach((element) => {
    $calculator.find(element.class).html('&nbsp;')
  })
}

const hideErrors = ($calculator: JQuery<HTMLElement>, input: string): void => {
  $calculator.removeClass('govuk-form-group--error')
    .find(input).removeClass('govuk-input--error').end()
    .find('.govuk-error-message')
    .addClass('govuk-visually-hidden')
}

const processResults = (result: Result, $calculator: JQuery<HTMLElement>, formElements: FormElements): void => {
  if (result) {
    if (result.error) {
      showErrors($calculator, formElements)
    } else {
      $calculator.removeClass('supplier-record__calculator--muted')
      hideErrors($calculator, formElements.input)

      formElements.outputs.forEach((element) => {
        $calculator.find(element.class).text(numberToCurrency(result[element.output]))
      })
    }
  } else {
    $calculator.addClass('supplier-record__calculator--muted')
    hideErrors($calculator, formElements.input)

    formElements.outputs.forEach((element) => {
      $calculator.find(element.class).html('&nbsp;')
    })
  }
}

const initSupplyTeachersSupplierMarkupCalculator = () => {
  $('.supplier-record__calculator input').on('change', (event: JQuery.ChangeEvent) => {
    const $input: JQuery<HTMLElement> = $(event.currentTarget)
    const $form: JQuery<HTMLFormElement> = $input.parents('form')
    const $calculator: JQuery<HTMLElement> = $input.parents('.supplier-record__calculator')
    const url: string = $form.attr('action') as string
    const data = `${$form.find('input[type="hidden"]').serialize()}&${$input.serialize()}`
    let formElements: FormElements
  
    if ($('.supplier-record__finders-fee').length) {
      formElements = fixedTermCalculator
    } else {
      formElements = agencyList
    }
  
    $.get(url, data, (result) => {
      processResults(result, $calculator, formElements)
    }, 'json')
      .fail(() => {
        showErrors($calculator, formElements)
      })
  })
  
  $('.supplier-record__calculate-markup').hide()
  
  $('.supplier-record__calculator-form').on('submit', (event: JQuery.SubmitEvent) => {
    event.preventDefault()
  })
}

export default initSupplyTeachersSupplierMarkupCalculator
