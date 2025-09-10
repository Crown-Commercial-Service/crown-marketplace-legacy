import initAdminUpload from './shared/adminUpload'
import initBasket from './shared/basket'
import initCookieBanner from './shared/cookieBanner'
import initFilterTable from './shared/filterTable'
import initGoogleAnalyticsDataLayer from './shared/googleAnalyticsDataLayer'
import initReportProgress from './shared/reportProgress'
import initSearchAllSuppliers from './supplyTeachers/searchAllSuppliers'
import initSupplyTeachersAdminUpload from './supplyTeachers/adminUpload'
import initSupplyTeachersSupplierMarkupCalculator from './supplyTeachers/supplierMarkupCalculator'

const initAll = () => {
  initAdminUpload()
  initBasket()
  initCookieBanner()
  initFilterTable()
  initGoogleAnalyticsDataLayer()
  initReportProgress()

  initSupplyTeachersAdminUpload()
  initSupplyTeachersSupplierMarkupCalculator()
  initSearchAllSuppliers()
}

export { initAll }
