import initAdminUpload from './shared/adminUpload'
import initBasket from './shared/basket'
import initCookieBanner from './shared/cookieBanner'
import initGoogleAnalyticsDataLayer from './shared/googleAnalyticsDataLayer'
import initRemoteForm from './shared/remoteForm'
import initSupplyTeachersAdminUpload from './supplyTeachers/adminUpload'
import initSupplyTeachersSupplierMarkupCalculator from './supplyTeachers/supplierMarkupCalculator'

const initAll = () => {
  initAdminUpload()
  initBasket()
  initCookieBanner()
  initGoogleAnalyticsDataLayer()

  initSupplyTeachersAdminUpload()
  initSupplyTeachersSupplierMarkupCalculator()
  initRemoteForm()
}

export { initAll }
