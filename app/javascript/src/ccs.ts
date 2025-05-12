import initAdminUpload from './shared/adminUpload'
import initBasket from './shared/basket'
import initCookieBanner from './shared/cookieBanner'
import initGoogleAnalyticsDataLayer from './shared/googleAnalyticsDataLayer'
import initSearchAllSuppliers from './supplyTeachers/searchAllSuppliers'
import initSupplyTeachersAdminUpload from './supplyTeachers/adminUpload'
import initSupplyTeachersSupplierMarkupCalculator from './supplyTeachers/supplierMarkupCalculator'

const initAll = () => {
  initAdminUpload()
  initBasket()
  initCookieBanner()
  initGoogleAnalyticsDataLayer()

  initSupplyTeachersAdminUpload()
  initSupplyTeachersSupplierMarkupCalculator()
  initSearchAllSuppliers()
}

export { initAll }
