interface CheckboxItemInterface {
  checkboxItemDetails: CheckboxItemDetails
  toggleChecked: (isChecked: boolean) => void
}

interface CheckboxSectionInterface {
  uncheckAll: () => void
}

interface BasketItem {
  removeBasketItem: () => void
}

type BasketInterface =  {
  addItemToBasket: (checkboxItemDetails: CheckboxItem) => BasketItem
  appendBasketItem: (basketItemHTML: string) => void
  removeBasketItem: () => void
}

type CheckboxItemDetails = {
  groupID: string
  itemID: string
  text: string
}

class CheckboxItem  implements CheckboxItemInterface {
  private $checkBox: JQuery<HTMLInputElement>
  private basket: Basket
  private basketItem?: BasketItem
  checkboxItemDetails: CheckboxItemDetails

  constructor(basket: Basket, $checkBox: JQuery<HTMLInputElement>) {
    this.basket = basket
    this.$checkBox = $checkBox

    this.checkboxItemDetails = {
      groupID: $checkBox.attr('sectionid') || '',
      itemID: $checkBox.attr('id') || '',
      text: $(`label[for="${$checkBox.attr('id')}"]`).text() || ''
    }

    if (this.isChecked() && this.basketItem === undefined) this.basketItem = this.basket.addItemToBasket(this)

    this.setEventListeners()
  }

  private isChecked = (): boolean => this.$checkBox.is(':checked')

  private setEventListeners = (): void => {
    this.$checkBox.on('click', (): void => this.toggleChecked(this.isChecked()))
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
}

class CheckboxSection implements CheckboxSectionInterface {
  private checkBoxes: Array<CheckboxItem> = []

  constructor (basket: Basket, $section: JQuery<HTMLElement>) {
    $section.find('div.govuk-checkboxes__item:not(.ccs-select-all) > input.govuk-checkboxes__input').each((_index: number, checkBox: HTMLElement) => {
      this.checkBoxes.push(new CheckboxItem(basket, $(checkBox) as JQuery<HTMLInputElement>))
    })
  }

  uncheckAll = (): void => this.checkBoxes.forEach((checkBox: CheckboxItem) => checkBox.toggleChecked(false))
}

class BasketItem implements BasketItem {
  private basket: Basket
  private checkboxNamedItem: CheckboxItem
  private $basketItem: JQuery<HTMLElement>
  private $removeItemLink: JQuery<HTMLAnchorElement>

  constructor(basket: Basket, checkboxNamedItem: CheckboxItem) {
    this.basket = basket
    this.checkboxNamedItem = checkboxNamedItem

    basket.appendBasketItem(this.getBasketItemHTML())

    this.$basketItem = $(`#${checkboxNamedItem.checkboxItemDetails.itemID}_basket`)
    this.$removeItemLink = $(`#${checkboxNamedItem.checkboxItemDetails.itemID}_removeLink`)

    this.setEventListener()
  }

  private getBasketItemHTML = (): string => {
    const itemText = `<span>${this.checkboxNamedItem.checkboxItemDetails.text}</span>`
    const removeLink = `<a id="${this.checkboxNamedItem.checkboxItemDetails.itemID}_removeLink" groupid="${this.checkboxNamedItem.checkboxItemDetails.groupID}" name="${this.checkboxNamedItem.checkboxItemDetails.itemID}_removeLink" href="" class="govuk-link govuk-link--no-visited-state">Remove</a>`

    return `<li style="margin-top:0; word-break: keep-all;" groupid="${this.checkboxNamedItem.checkboxItemDetails.groupID}" class="govuk-list" id="${this.checkboxNamedItem.checkboxItemDetails.itemID}_basket">${itemText}${removeLink}</li>`
  }

  private setEventListener = (): void => {
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
  private $basket: JQuery<HTMLElement> = $('#css-list-basket')
  private $itemList: JQuery<HTMLUListElement> = this.$basket.find('ul')
  private $numberOfItems: JQuery<HTMLElement> = this.$basket.find('h2')
  private $removeAllLink: JQuery<HTMLAnchorElement> = this.$basket.find('div > a') as JQuery<HTMLAnchorElement>
  private checkboxSection: CheckboxSection

  private textOptions: {[key: string]: string} = {
    no_items: this.$numberOfItems.data('txt02'),
    single_item: this.$numberOfItems.data('txt03'),
    plural_items: this.$numberOfItems.data('txt01')
  }

  constructor() {
    this.checkboxSection = new CheckboxSection(this, $('#selection-checkboxes'))

    this.updateNumberOfItems()

    this.setEventListeners()
  }

  private numberOfItems = (): number => this.$itemList.find('li').length

  private updateNumberOfItems = (): void => {
    const numberOfItems: number = this.numberOfItems()

    let numberOfItemsNumber = String(numberOfItems)
    let numberOfItemsText
    let isShown = true

    if (numberOfItems == 0) {
      numberOfItemsNumber = ''
      numberOfItemsText = this.textOptions.no_items
      isShown = false
    } else if (numberOfItems == 1) {
      numberOfItemsText = this.textOptions.single_item
    } else {
      numberOfItemsText = this.textOptions.plural_items
    }

    this.$numberOfItems.html(`<span id="selected-items-count">${numberOfItemsNumber}</span> <span>${numberOfItemsText}</span>`)
    this.toggleRemoveAllButton(isShown)
  }

  private toggleRemoveAllButton = (isShown: boolean): void => {
    isShown ? this.$removeAllLink.removeClass('ccs-remove') : this.$removeAllLink.addClass('ccs-remove')
  }

  private removeAll = (event: JQuery.ClickEvent): void => {
    event.preventDefault()

    this.checkboxSection.uncheckAll()

    this.updateNumberOfItems()
  }

  private setEventListeners = (): void => {
    this.$removeAllLink.on('click', (event: JQuery.ClickEvent) => this.removeAll(event))
  }

  addItemToBasket = (checkboxNamedItem: CheckboxItem): BasketItem => {
    const basketItem = new BasketItem(this, checkboxNamedItem)

    this.updateNumberOfItems()

    return basketItem
  }

  appendBasketItem = (basketItemHTML: string): void => {
    this.$itemList.append(basketItemHTML)
  }

  removeBasketItem = (): void => this.updateNumberOfItems()

}

const initBasket = () => {
  if ($('#selection-checkboxes').length > 0) new Basket()
}

export default initBasket
