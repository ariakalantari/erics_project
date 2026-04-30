import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  emit() {
    const detail = {}
    this.checkboxTargets.forEach((cb) => {
      detail[cb.dataset.filterKey] = cb.checked
    })
    window.dispatchEvent(new CustomEvent("filters:changed", { detail }))
  }

  reset() {
    this.checkboxTargets.forEach((cb) => {
      const key = cb.dataset.filterKey
      cb.checked = key.startsWith("status:")
    })
    this.emit()
  }
}
