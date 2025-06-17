import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.formTarget.addEventListener("turbo:submit-end", (event) => {
      if (event.detail.success) {
        this.formTarget.reset()
      }
    })
  }
}