function numberToCurrency(number) {
  return `£${number.toFixed(2)}`;
}

const agencyList = {
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
};

const fixedTermCalculator = {
  input: '.calculator-form__annual-salary-input',
  outputs: [
    {
      class: '.supplier-record__finders-fee',
      output: 'finders_fee',
    },
  ],
};

function showErrors($calculator, formElements) {
  $calculator.addClass('govuk-form-group govuk-form-group--error')
    .find(formElements.input).addClass('govuk-input--error').end()
    .find('.govuk-error-message')
    .removeClass('govuk-visually-hidden')
    .end();

  formElements.outputs.forEach((element) => {
    $calculator.find(element.class).html('&nbsp;');
  });
}

function hideErrors($calculator, input) {
  $calculator.removeClass('govuk-form-group--error')
    .find(input).removeClass('govuk-input--error').end()
    .find('.govuk-error-message')
    .addClass('govuk-visually-hidden');
}

function processResults(result, $calculator, formElements) {
  if (result) {
    if (result.error) {
      showErrors($calculator, formElements);
    } else {
      $calculator.removeClass('supplier-record__calculator--muted');
      hideErrors($calculator, formElements.input);

      formElements.outputs.forEach((element) => {
        $calculator.find(element.class).text(numberToCurrency(result[element.output]));
      });
    }
  } else {
    $calculator.addClass('supplier-record__calculator--muted');
    hideErrors($calculator, formElements.input);

    formElements.outputs.forEach((element) => {
      $calculator.find(element.class).html('&nbsp;');
    });
  }
}

$('.supplier-record__calculator input').on('change', (e) => {
  const $input = $(e.currentTarget);
  const $form = $input.parents('form');
  const $calculator = $input.parents('.supplier-record__calculator');
  const url = $form.attr('action');
  const data = `${$form.find('input[type="hidden"]').serialize()}&${$input.serialize()}`;
  let formElements;

  if ($('.supplier-record__finders-fee').length) {
    formElements = fixedTermCalculator;
  } else {
    formElements = agencyList;
  }

  $.get(url, data, (result) => {
    processResults(result, $calculator, formElements);
  }, 'json')
    .fail(() => {
      showErrors($calculator, formElements);
    });
});

$('.supplier-record__calculate-markup').hide();

$('.supplier-record__calculator-form').on('submit', (e) => {
  e.preventDefault();
});
