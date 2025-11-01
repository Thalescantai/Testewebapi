import { Controller } from "@hotwired/stimulus"

// Formats CEP inputs with the 00000-000 mask.
export default class extends Controller {
  connect() {
    this.format()
  }

  format() {
    const digits = this.element.value.replace(/\D/g, "").slice(0, 8)

    let formatted = digits
    if (digits.length > 5) {
      formatted = `${digits.slice(0, 5)}-${digits.slice(5)}`
    }

    this.element.value = formatted
  }
}
