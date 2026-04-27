const printPage = () => {
  window.print()
}

const initPrintPage = () => {
  $('.ga-print-link').on('click', (event) => {
    event.preventDefault()
    printPage()
  })
}

export default initPrintPage