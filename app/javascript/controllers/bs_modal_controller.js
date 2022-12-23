import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bs-modal"
export default class extends Controller {
  connect() {
    this.modal = new bootstrap.Modal(this.element)
    this.modal.show()
    console.log('op')
  }

  disconnect() {
    this.modal.hide()
    console.log('op')
  }

  submitEnd(event) {
    this.modal.hide()
  }
}
