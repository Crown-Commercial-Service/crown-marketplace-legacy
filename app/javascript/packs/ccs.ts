import initAdminUpload from '../src/shared/adminUpload'
import initBasket from '../src/shared/basket'
import initCookieBanner from '../src/shared/cookieBanner'
import initPasswordStrength from '../src/shared/passwordStrength'
import initSupplyTeachersAdminUpload from '../src/supplyTeachers/adminUpload'
import initSupplyTeachersSupplierMarkupCalculator from '../src/supplyTeachers/supplierMarkupCalculator'

$(document).on('turbolinks:load', () => {
  initAdminUpload()
  initBasket()
  initCookieBanner()
  initPasswordStrength()

  initSupplyTeachersAdminUpload()
  initSupplyTeachersSupplierMarkupCalculator()
})
