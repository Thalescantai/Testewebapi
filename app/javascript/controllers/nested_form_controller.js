import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]
  static values = {
    wrapperSelector: String,
    maxItems: Number
  }

  add(event) {
    event.preventDefault()
    if (this.hasMaxItemsValue && this.itemCount >= this.maxItemsValue) {
      return
    }

    const uniqueId = Date.now().toString()
    const content = this.templateHTML.replace(/NEW_RECORD/g, uniqueId)
    this.containerTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest(this.wrapperSelector)
    if (!wrapper) return

    const destroyField = wrapper.querySelector("input[name$='[_destroy]']")
    if (destroyField) {
      destroyField.value = "1"
      wrapper.style.display = "none"
    } else {
      wrapper.remove()
    }
  }

  get templateHTML() {
    return this.templateTarget.innerHTML.trim()
  }

  get wrapperSelector() {
    return this.hasWrapperSelectorValue ? this.wrapperSelectorValue : ".nested-fields"
  }

  get itemCount() {
    return this.containerTarget.querySelectorAll(this.wrapperSelector).length
  }
}
