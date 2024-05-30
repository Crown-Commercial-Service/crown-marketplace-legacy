import initAdminUpload from './shared/adminUpload'
import initBasket from './shared/basket'
import initCookieBanner from './shared/cookieBanner'
import initGoogleAnalyticsDataLayer from './shared/googleAnalyticsDataLayer'
import initHeader from './shared/header'
import initPasswordStrength from './shared/passwordStrength'
import initSupplyTeachersAdminUpload from './supplyTeachers/adminUpload'
import initSupplyTeachersSupplierMarkupCalculator from './supplyTeachers/supplierMarkupCalculator'

const initAll = () => {
  initAdminUpload()
  initBasket()
  initCookieBanner()
  initGoogleAnalyticsDataLayer()
  initHeader()
  initPasswordStrength()

  initSupplyTeachersAdminUpload()
  initSupplyTeachersSupplierMarkupCalculator()
}

export { initAll }
