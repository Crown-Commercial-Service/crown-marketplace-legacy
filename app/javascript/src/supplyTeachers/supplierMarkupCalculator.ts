interface FormElements {
  input: string
  outputs: FormElementsOutputs[]
}

interface FormElementsOutputs {
  class: string
  output: ResultOutput
}

type ResultOutput = 'worker_cost' | 'agency_fee' | 'finders_fee'

interface Result {
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
      output: 'worker_cost'
    },
    {
      class: '.supplier-record__agency-fee',
      output: 'agency_fee'
    }
  ]
}

const fixedTermCalculator: FormElements = {
  input: '.calculator-form__annual-salary-input',
  outputs: [
    {
      class: '.supplier-record__finders-fee',
      output: 'finders_fee'
    }
  ]
}

class SupplyTeachersSupplierMarkupCalculator {
  $input: JQuery<HTMLInputElement>
  $form: JQuery<HTMLFormElement>
  $calculator: JQuery<HTMLElement>
  url: string
  formElements: FormElements

  constructor ($input: JQuery<HTMLInputElement>, formElements: FormElements) {
    this.$input = $input
    this.$form = $input.parents('form')
    this.$calculator= $input.parents('.supplier-record__calculator')
    this.url = this.$form.attr('action') as string
    this.formElements = formElements
  }

  init () {
    this.$input.on('change', () => {
      const data = `${this.$form.find('input[type="hidden"]').serialize()}&${this.$input.serialize()}`
  
      $.get(this.url, data, (result) => {
        this.processResults(result)
      }, 'json')
        .fail(() => {
          this.showErrors()
        }).catch(() => {
          this.showErrors()
        })
    })
  }

  showErrors () {
    this.$calculator.addClass('govuk-form-group govuk-form-group--error')
      .find(this.formElements.input).addClass('govuk-input--error').end()
      .find('.govuk-error-message')
      .removeClass('govuk-visually-hidden')
      .end()
  
    this.formElements.outputs.forEach((element) => {
      this.$calculator.find(element.class).html('&nbsp;')
    })
  }
  
  hideErrors () {
    this.$calculator.removeClass('govuk-form-group--error')
      .find(this.formElements.input).removeClass('govuk-input--error').end()
      .find('.govuk-error-message')
      .addClass('govuk-visually-hidden')
  }
  
  processResults (result: Result) {
    if (result) {
      if (result.error) {
        this.showErrors()
      } else {
        this.$calculator.removeClass('supplier-record__calculator--muted')
        this.hideErrors()
  
        this.formElements.outputs.forEach((element) => {
          this.$calculator.find(element.class).text(numberToCurrency(result[element.output]))
        })
      }
    } else {
      this.$calculator.addClass('supplier-record__calculator--muted')
      this.hideErrors()
  
      this.formElements.outputs.forEach((element) => {
        this.$calculator.find(element.class).html('&nbsp;')
      })
    }
  }
}

const initSupplyTeachersSupplierMarkupCalculator = (): void => {
  const formElements: FormElements = $('.supplier-record__finders-fee').length ? fixedTermCalculator : agencyList

  $<HTMLInputElement>('.supplier-record__calculator input').each((_index, element) => {
    new SupplyTeachersSupplierMarkupCalculator($(element), formElements).init()
  })

  $('.supplier-record__calculate-markup').hide()

  $('.supplier-record__calculator-form').on('submit', (event: JQuery.SubmitEvent) => {
    event.preventDefault()
  })
}

export default initSupplyTeachersSupplierMarkupCalculator
