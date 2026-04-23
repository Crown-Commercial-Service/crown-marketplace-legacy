import { PostProcessResultFunction, RemoteFormHandler } from '../shared/remoteForm'

const updateErrorMessages: PostProcessResultFunction = (responseJSON) => {
  if (responseJSON.error_message_html) {
    if ($('#agency_postcode-error').length === 0) {
      $('#agency_postcode-form-group').addClass('govuk-form-group--error')
      $('#agency_postcode').before(responseJSON.error_message_html)
    }
  } else {
    if ($('#agency_postcode-error').length > 0) {
      $('#agency_postcode-form-group').removeClass('govuk-form-group--error')
      $('#agency_postcode-error').remove()
    }
  }
}

const initSearchAllSuppliers = () => {
  if($('#agency-table').length > 0) {
    new RemoteFormHandler('agency-table', updateErrorMessages).init()
  }
}

export default initSearchAllSuppliers
