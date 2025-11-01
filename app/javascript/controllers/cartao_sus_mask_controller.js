import { Controller } from "@hotwired/stimulus"

// Formats Cartão SUS (CNS) inputs as 000 0000 0000 0000.
export default class extends Controller {
  connect() {
    this.format()
  }

  format() {
    const digits = this.element.value.replace(/\D/g, "").slice(0, 15)

    let formatted = digits
    if (digits.length > 11) {
      formatted = `${digits.slice(0, 3)} ${digits.slice(3, 7)} ${digits.slice(7, 11)} ${digits.slice(11)}`
    } else if (digits.length > 7) {
      formatted = `${digits.slice(0, 3)} ${digits.slice(3, 7)} ${digits.slice(7)}`
    } else if (digits.length > 3) {
      formatted = `${digits.slice(0, 3)} ${digits.slice(3)}`
    }

    this.element.value = formatted
  }
}
