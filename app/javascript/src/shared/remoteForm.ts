import { post } from '@rails/request.js'

type ResponseJSON = {
  updateId: string,
  html: string
}


class RemoteFormHandler {
  $form: JQuery<HTMLFormElement>
  $submitButton: JQuery<HTMLInputElement>
  $input: JQuery<HTMLInputElement>
  url: string
  inputName: string

  constructor () {
    this.$form = $('form[data-remote="true"]')
    this.$input = this.$form.find('input[type="search"]')
    this.$submitButton = this.$form.find('input[type="submit"]')
    this.url = this.$form.attr('action') as string
    this.inputName = this.$input.attr('name') as string
  }

  init() {
    this.$form.on('submit', async (event) => {
      event.preventDefault()

      this.$submitButton.attr('disabled', 'disabled')
      this.$submitButton.attr('aria-disabled', 'true')

      await this.handleRemoteForm()

      this.$submitButton.removeAttr('disabled')
      this.$submitButton.removeAttr('aria-disabled')
    })
  }

  private async handleRemoteForm() {
    try {
      const response = await post(
        this.url,
        {
          body: JSON.stringify({
            [this.inputName]: this.$input.val()
          }),
          contentType: 'application/json',
          responseKind: 'json',
        }
      )

      if (response.ok) {
        const responseJSON: ResponseJSON = await response.json

        this.replaceHtml(responseJSON)
      }
    } finally {
      // Do nothing if failure
    }
  }

  private replaceHtml(responseJSON: ResponseJSON) {
    $(`#${responseJSON.updateId}`).html(responseJSON.html)
  }
}


const initRemoteForm  =() => {
  const remoteFormHandler = new RemoteFormHandler()
  remoteFormHandler.init()
}

export default initRemoteForm
