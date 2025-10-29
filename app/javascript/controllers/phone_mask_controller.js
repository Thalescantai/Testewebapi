import { Controller } from "@hotwired/stimulus"

// Formats phone inputs as (xx) xxxxx-xxxx.
export default class extends Controller {
  connect() {
    this.format()
  }

  format() {
    const digits = this.element.value.replace(/\D/g, "").slice(0, 11)

    let formatted = digits
    if (digits.length > 6) {
      formatted = `(${digits.slice(0, 2)}) ${digits.slice(2, 7)}-${digits.slice(7)}`
    } else if (digits.length > 2) {
      formatted = `(${digits.slice(0, 2)}) ${digits.slice(2)}`
    } else if (digits.length > 0) {
      formatted = `(${digits}`
    }

    this.element.value = formatted
  }
}
