function numberToCurrency(number) {
  return `£${number.toFixed(2)}`;
}

function agencyList(result, calculator) {
  if (result) {
    calculator.removeClass('supplier-record__calculator--muted govuk-form-group--error')
      .find('.calculator-form__day-rate-input').removeClass('govuk-input--error').end()
      .find('.govuk-error-message')
      .addClass('govuk-visually-hidden')
      .end()
      .find('.supplier-record__worker-cost')
      .text(numberToCurrency(result.worker_cost))
      .end()
      .find('.supplier-record__agency-fee')
      .text(numberToCurrency(result.agency_fee));
  } else {
    calculator.addClass('supplier-record__calculator--muted').removeClass('govuk-form-group--error')
      .find('.calculator-form__day-rate-input').removeClass('govuk-input--error')
      .end()
      .find('.calculator-form__annual-salary-input')
      .removeClass('govuk-input--error')
      .end()
      .find('.govuk-error-message')
      .addClass('govuk-visually-hidden')
      .end()
      .find('.supplier-record__worker-cost')
      .text('')
      .end()
      .find('.supplier-record__agency-fee')
      .text('');
  }
}

function fixedTermCalculator(result, calculator) {
  if (result) {
    calculator.removeClass('supplier-record__calculator--muted govuk-form-group--error')
      .find('.calculator-form__annual-salary-input').removeClass('govuk-input--error').end()
      .find('.govuk-error-message')
      .addClass('govuk-visually-hidden')
      .end()
      .find('.supplier-record__finders-fee')
      .text(numberToCurrency(result.finders_fee));
  } else {
    calculator.addClass('supplier-record__calculator--muted').removeClass('govuk-form-group--error')
      .find('.calculator-form__annual-salary-input').removeClass('govuk-input--error')
      .end()
      .find('.govuk-error-message')
      .addClass('govuk-visually-hidden')
      .end()
      .find('.supplier-record__worker-cost')
      .text('')
      .end()
      .find('.supplier-record__agency-fee')
      .text('');
  }
}

$('.supplier-record__calculator input').on('change', function () {
  const $input = $(this);
  const $form = $input.parents('form');
  const $calculator = $input.parents('.supplier-record__calculator');
  const url = $form.attr('action');
  const data = `${$form.find('input[type="hidden"]').serialize()}&${$input.serialize()}`;

  $.get(url, data, (result) => {
    if ($('.supplier-record__finders-fee').length) {
      fixedTermCalculator(result, $calculator);
    } else {
      agencyList(result, $calculator);
    }
  }, 'json')
    .fail(() => {
      $calculator.addClass('govuk-form-group govuk-form-group--error')
        .find('.calculator-form__day-rate-input').addClass('govuk-input--error').end()
        .find('.calculator-form__annual-salary-input')
        .addClass('govuk-input--error')
        .end()
        .find('.govuk-error-message')
        .removeClass('govuk-visually-hidden')
        .end()
        .find('.supplier-record__worker-cost')
        .text('')
        .end()
        .find('.supplier-record__agency-fee')
        .text('');
    });
});

$('.supplier-record__calculate-markup').hide();

$('.supplier-record__calculator-form').on('submit', (e) => {
  e.preventDefault();
});
