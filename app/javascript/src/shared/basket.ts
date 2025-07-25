interface CheckboxItemInterface {
  checkboxItemDetails: CheckboxItemDetails
  toggleChecked: (isChecked: boolean) => void
}

interface CheckboxSectionInterface {
  checkBoxes: CheckboxItem[]
  uncheckAll: () => void
}

interface BasketItemInterface {
  removeBasketItem: () => void
}

interface BasketInterface {
  addItemToBasket: (checkboxItemDetails: CheckboxItem) => BasketItem
  appendBasketItem: (basketItemHTML: string) => void
  removeBasketItem: () => void
}

interface CheckboxItemDetails {
  groupID: string
  itemID: string
  text: string
}

class CheckboxItem implements CheckboxItemInterface {
  private readonly $checkBoxItem: JQuery<HTMLInputElement>
  private readonly $checkBox: JQuery<HTMLInputElement>
  private readonly basket: Basket
  private basketItem?: BasketItem
  private checkBoxSanatizedValue: string
  checkboxItemDetails: CheckboxItemDetails

  constructor (basket: Basket, $checkBoxItem: JQuery<HTMLInputElement>) {
    this.basket = basket
    this.$checkBoxItem = $checkBoxItem
    this.$checkBox = $checkBoxItem.find('input.govuk-checkboxes__input')
    this.checkBoxSanatizedValue = ($checkBoxItem.find('label').text() || '').toLowerCase().replaceAll(' ', '')

    this.checkboxItemDetails = {
      groupID: this.$checkBox.attr('sectionid') ?? '',
      itemID: this.$checkBox.attr('id') ?? '',
      text: $(`label[for="${this.$checkBox.attr('id') ?? ''}"]`).text() || ''
    }

    if (this.isChecked() && this.basketItem === undefined) this.basketItem = this.basket.addItemToBasket(this)

    this.setEventListeners()
  }

  private readonly isChecked = (): boolean => this.$checkBox.is(':checked')

  private readonly setEventListeners = (): void => {
    this.$checkBox.on('click', (): void => { this.toggleChecked(this.isChecked()) })
  }

  toggleChecked = (isChecked: boolean): void => {
    if (isChecked) {
      if (this.basketItem === undefined) this.basketItem = this.basket.addItemToBasket(this)
    } else if (this.basketItem !== undefined) {
      this.basketItem.removeBasketItem()
      delete this.basketItem
    }

    this.$checkBox.prop('checked', isChecked)
  }

  toggleVisivility = (isShown: boolean): void => {
    this.$checkBoxItem.toggleClass('govuk-visually-hidden', !isShown)
  }

  showIfInSearch = (search: string): void => {
    this.toggleVisivility(this.checkBoxSanatizedValue.indexOf(search) > -1)
  }
}

class CheckboxSection implements CheckboxSectionInterface {
  checkBoxes: CheckboxItem[] = []

  constructor (basket: Basket, $section: JQuery<HTMLElement>) {
    $section.find('div.govuk-checkboxes__item:not(.ccs-select-all)').each((_index: number, checkBoxItem: HTMLElement) => {
      this.checkBoxes.push(new CheckboxItem(basket, $(checkBoxItem) as JQuery<HTMLInputElement>))
    })
  }

  uncheckAll = (): void => { this.checkBoxes.forEach((checkBox: CheckboxItem) => { checkBox.toggleChecked(false) }) }
}

class BasketSearch {
  private basket: Basket
  private $searchInput: JQuery<HTMLInputElement>

  constructor (basket: Basket, $searchFormGroup: JQuery<HTMLElement>) {
    this.basket = basket
    this.$searchInput = $searchFormGroup.find('input')

    this.setEventListeners()
  }

  private readonly setEventListeners = (): void => {
    this.$searchInput.on('input', (event) => {
      this.basket.searchItems(this.sanitizeSearch(event.target.value))
    })
  }

  private sanitizeSearch = (search: string): string => search.toLowerCase().replaceAll(' ', '')
}

class BasketItem implements BasketItemInterface {
  private readonly basket: Basket
  private readonly checkboxNamedItem: CheckboxItem
  private readonly $basketItem: JQuery<HTMLElement>
  private readonly $removeItemLink: JQuery<HTMLAnchorElement>

  constructor (basket: Basket, checkboxNamedItem: CheckboxItem) {
    this.basket = basket
    this.checkboxNamedItem = checkboxNamedItem

    basket.appendBasketItem(this.getBasketItemHTML())

    this.$basketItem = $(`#${checkboxNamedItem.checkboxItemDetails.itemID}_basket`)
    this.$removeItemLink = $(`#${checkboxNamedItem.checkboxItemDetails.itemID}_removeLink`)

    this.setEventListener()
  }

  private readonly getBasketItemHTML = (): string => {
    const itemText = `<span>${this.checkboxNamedItem.checkboxItemDetails.text}</span>`
    const removeLink = `<a id="${this.checkboxNamedItem.checkboxItemDetails.itemID}_removeLink" groupid="${this.checkboxNamedItem.checkboxItemDetails.groupID}" name="${this.checkboxNamedItem.checkboxItemDetails.itemID}_removeLink" href="" class="govuk-link govuk-link--no-visited-state">Remove</a>`

    return `<li class="ccs-list-basket__item" groupid="${this.checkboxNamedItem.checkboxItemDetails.groupID}" class="govuk-list" id="${this.checkboxNamedItem.checkboxItemDetails.itemID}_basket">${itemText}${removeLink}</li>`
  }

  private readonly setEventListener = (): void => {
    this.$removeItemLink.on('click', (event: JQuery.ClickEvent) => {
      event.preventDefault()

      this.checkboxNamedItem.toggleChecked(false)
    })
  }

  removeBasketItem = (): void => {
    this.$basketItem.remove()

    this.basket.removeBasketItem()
  }
}

class Basket implements BasketInterface {
  private readonly $basket: JQuery<HTMLElement> = $('#css-list-basket')
  private readonly $itemList: JQuery<HTMLUListElement> = this.$basket.find('ul')
  private readonly $numberOfItems: JQuery<HTMLElement> = this.$basket.find('h2')
  private readonly $removeAllLink: JQuery<HTMLAnchorElement> = this.$basket.find('div > a') as JQuery<HTMLAnchorElement>
  private readonly checkboxSection: CheckboxSection

  private readonly textOptions: Record<string, string> = {
    no_items: this.$numberOfItems.data('txt02'),
    single_item: this.$numberOfItems.data('txt03'),
    plural_items: this.$numberOfItems.data('txt01')
  }

  constructor () {
    this.checkboxSection = new CheckboxSection(this, $('#selection-checkboxes'))

    if ($('[data-module="search-items"').length) {
      new BasketSearch(this, $('[data-module="search-items"'))
    }

    this.updateNumberOfItems()

    this.setEventListeners()
  }

  private readonly numberOfItems = (): number => this.$itemList.find('li').length

  private readonly updateNumberOfItems = (): void => {
    const numberOfItems: number = this.numberOfItems()

    let numberOfItemsNumber = String(numberOfItems)
    let numberOfItemsText
    let isShown = true

    if (numberOfItems === 0) {
      numberOfItemsNumber = ''
      numberOfItemsText = this.textOptions.no_items
      isShown = false
    } else if (numberOfItems === 1) {
      numberOfItemsText = this.textOptions.single_item
    } else {
      numberOfItemsText = this.textOptions.plural_items
    }

    this.$numberOfItems.html(`<span id="selected-items-count">${numberOfItemsNumber}</span> <span>${numberOfItemsText}</span>`)
    this.toggleRemoveAllButton(isShown)
  }

  private readonly toggleRemoveAllButton = (isShown: boolean): void => {
    this.$removeAllLink.toggle(isShown)
  }

  private readonly removeAll = (event: JQuery.ClickEvent): void => {
    event.preventDefault()

    this.checkboxSection.uncheckAll()

    this.updateNumberOfItems()
  }

  private readonly setEventListeners = (): void => {
    this.$removeAllLink.on('click', (event: JQuery.ClickEvent) => { this.removeAll(event) })
  }

  addItemToBasket = (checkboxNamedItem: CheckboxItem): BasketItem => {
    const basketItem = new BasketItem(this, checkboxNamedItem)

    this.updateNumberOfItems()

    return basketItem
  }

  appendBasketItem = (basketItemHTML: string): void => {
    this.$itemList.append(basketItemHTML)
  }

  removeBasketItem = (): void => { this.updateNumberOfItems() }

  searchItems = (search: string): void => {
    if (search === '') {
      this.checkboxSection.checkBoxes.forEach((checkboxItem) => checkboxItem.toggleVisivility(true))
    } else {
      this.checkboxSection.checkBoxes.forEach((checkboxItem) => checkboxItem.showIfInSearch(search))
    }
  }
}

const initBasket = (): void => {
  if ($('#selection-checkboxes').length > 0) new Basket()
}

export default initBasket
