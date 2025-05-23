import jQuery from 'jquery'
import { initAll as initCCS } from './src/ccs'
import { initAll as initGOVUKFrontend } from 'govuk-frontend'
import { initAll as initCCSFrontend } from 'ccs-frontend'

// Initiate jQuery
window.$ = window.jQuery = jQuery

$(() => {
  // Initiate GOV.UK Frontend
  initGOVUKFrontend()

  // Initiate CCS Frontend
  initCCSFrontend()

  // Initiate CCS
  initCCS()
})
