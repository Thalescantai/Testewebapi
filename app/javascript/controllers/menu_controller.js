import { Controller } from "@hotwired/stimulus"

// Controls the hamburger menu visibility
export default class extends Controller {
  static targets = ["panel", "backdrop", "button"]

  connect() {
    this.isOpen = false
    this._syncAria()
  }

  toggle() {
    this.isOpen = !this.isOpen
    this._applyState()
  }

  close() {
    this.isOpen = false
    this._applyState()
  }

  _applyState() {
    this.panelTarget.classList.toggle("open", this.isOpen)
    this.backdropTarget.classList.toggle("visible", this.isOpen)
    this._syncAria()
  }

  _syncAria() {
    if (this.hasButtonTarget) {
      this.buttonTarget.setAttribute("aria-expanded", String(this.isOpen))
    }
    if (this.hasPanelTarget) {
      this.panelTarget.setAttribute("aria-hidden", String(!this.isOpen))
    }
  }
}

