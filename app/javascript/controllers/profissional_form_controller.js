import { Controller } from "@hotwired/stimulus"

// Handles conditional fields on the profissional form.
export default class extends Controller {
  static targets = ["cargoSelect", "crmField"]

  connect() {
    this.toggle()
  }

  toggle() {
    const shouldShowCrm = this.cargoSelectTarget.value === "medico"
    this.crmFieldTarget.style.display = shouldShowCrm ? "" : "none"
  }
}
