function ifChecked(sWrap, h) {
  let howmany;

  if (sWrap === false) {
    howmany = 0;
  } else {
    howmany = sWrap.find('.govuk-checkboxes__input:checked').length;
  }

  if (howmany > 0) {
    const txt = h.data('txt');
    h.find('.ccs-filter-no').text(howmany).end().find('.ccs-filter-txt')
      .text(txt)
      .end()
      .addClass('ccs-hint--show');
  } else {
    h.removeClass('ccs-hint--show').find('.ccs-filter-no').empty().end()
      .find('.ccs-filter-txt')
      .empty();
  }
}

function whenChecked(sWrap, h) {
  const allcheckbxs = sWrap.find('.govuk-checkboxes__input');

  allcheckbxs.on('change', () => {
    ifChecked(sWrap, h);
  });
}

function initSearchResults(id) {
  const accord = id.find('.ccs-at-checkbox-accordian');

  accord.each(function (index) {
    const shopWrap = $(this);

    const hint = shopWrap.find('.ccs-govuk-hint--selected');
    if (hint.length) {
      ifChecked(shopWrap, hint);
      whenChecked(shopWrap, hint);
    }

    const link = $(this).find('.ccs-at-btn-toggle');

    link.attr('aria-expanded', 'false').on('click', function (e) {
      e.preventDefault();

      $(this).attr('aria-expanded', $(this).attr('aria-expanded') === 'true' ? 'false' : 'true')
        .find('span').text((i, text) => (text === 'Hide' ? ' Show' : ' Hide'));

      if (shopWrap.hasClass('show')) {
        shopWrap.removeClass('show');
      } else {
        shopWrap.addClass('show');
      }
    });
  });

  const checkboxs = accord.find('.govuk-checkboxes__input');

  checkboxs.keypress(function (e) {
    if ((e.keyCode ? e.keyCode : e.which) == 13) {
      $(this).trigger('click');
    }
  });

  $('#ccs-clear-filters').on('click', (e) => {
    e.preventDefault();
    checkboxs.prop('checked', false);

    const hint = id.find('.ccs-govuk-hint--selected');
    if (hint.length) {
      ifChecked(false, hint);
    }
  });
}

function updateTitle(i, v, b) {
  const span = b.find('span:first-child');
  if (v === true) {
    span.text(i);
    $('#removeAll').removeClass('ccs-remove');
    headerTxt(b, true, i);
  } else {
    span.empty();
    $('#removeAll').addClass('ccs-remove');
    headerTxt(b, false, i);
  }
}

function headerTxt(header, t, count) {
  let tx;
  if (t === true) {
    tx = count > 1 ? header.data('txt01') : header.data('txt03');
  } else {
    tx = header.data('txt02');
  }
  header.find('span:last-child').text(tx);
}

function updateList(govb, id, basket) {
  let i = '';
  let thelist = '';
  let $this;
  const list = id.find('ul');
  const thecheckboxes = govb.find('.govuk-checkboxes__item').not('.ccs-select-all').find('.govuk-checkboxes__input:checked');

  list.find('.ccs-removethis').remove();

  if (thecheckboxes.length) {
    thecheckboxes.each(function (index) {
      $this = $(this);
      thelist = `${thelist}<li class="ccs-removethis"><span>${$this.next('label').text()}</span> <a href="#" class="govuk-link--no-visited-state" data-id="${$this.attr('id')}">Remove</a></li>`;
      i = index + 1;
    });
    updateTitle(i, true, basket);
  } else {
    updateTitle(i, false, basket);
  }

  list.append(thelist).find('a').on('click', function (e) {
    e.preventDefault();
    const thisbox = $(`#${$(this).data('id')}`);

    $(this).parent().remove();
    thisbox.prop('checked', false);
    i -= 1;
    if (i > 0) {
      updateTitle(i, true, basket);
    } else {
      updateTitle(i, false, basket);
    }

    const theparent = thisbox.parents('.govuk-checkboxes').find('.ccs-select-all').find('.govuk-checkboxes__input:checked');
    if (theparent.length) {
      theparent.prop('checked', false);
    }
  });

  $('#removeAll').on('click', function (e) {
    e.preventDefault();
    list.find('.ccs-removethis').remove();
    govb.find('.govuk-checkboxes__input:checked').prop('checked', false);
    headerTxt(basket, false, 0);
    $(this).addClass('ccs-remove').siblings().find('span:first-child')
      .empty();
  });
}

function initDynamicAccordian() {
  const govcheckboxes = $('#selection-checkboxes').find('.govuk-checkboxes');

  if (govcheckboxes.length > 0) {
    const id = $('#css-list-basket');
    const basketheader = id.find('.govuk-heading-m');
    headerTxt(basketheader, false, 0);

    govcheckboxes.each(function () {
      const hasAll = $(this).find('.ccs-select-all');
      const hasFull = $(this).find('.ccs-select-full');

      const thecheckboxes = $(this).find('.govuk-checkboxes__item')
        .not(hasAll).not(hasFull)
        .find('.govuk-checkboxes__input');

      if (hasAll.length) {
        const hasAllInput = hasAll.find('.govuk-checkboxes__input');

        hasAllInput.on('change', () => {
          const checkstate = hasAllInput.is(':checked');

          thecheckboxes.each(function () {
            if (checkstate) {
              $(this).prop('checked', true);
            } else {
              $(this).prop('checked', false);
            }
          });
          updateList(govcheckboxes, id, basketheader);
        });

        thecheckboxes.on('change', function () {
          if (!$(this).is(':checked')) {
            hasAll.find('.govuk-checkboxes__input').prop('checked', false);
          }
        });
      } else if (hasFull.length) {
        const hasFullInput = hasFull.find('.govuk-checkboxes__input');

        hasFullInput.on('change', function () {
          const checkstate = hasFullInput.is(':checked');

          if (checkstate) {
            $(this).prop('checked', true);
            thecheckboxes.prop('checked', false);
          }

          updateList(govcheckboxes, id, basketheader);
        });

        thecheckboxes.on('change', function () {
          if ($(this).is(':checked')) {
            hasFull.find('.govuk-checkboxes__input').prop('checked', false);
          }
        });
      }

      thecheckboxes.on('change', () => {
        updateList(govcheckboxes, id, basketheader);
      });

      updateList(govcheckboxes, id, basketheader);
    });
  }
}

function initCustomFnc() {
  const filt = $('#ccs-at-results-filters');
  if (filt.length) {
    initSearchResults(filt);
  }

  if ($('#ccs-dynamic-accordian').length) {
    initDynamicAccordian();
  }
}

jQuery(document).ready(() => {
  initCustomFnc();
});
