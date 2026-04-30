import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "chevron"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this.applyState()
  }

  toggle() {
    this.openValue = !this.openValue
  }

  openValueChanged() {
    this.applyState()
  }

  applyState() {
    if (this.hasPanelTarget) this.panelTarget.hidden = !this.openValue
    if (this.hasChevronTarget) {
      this.chevronTarget.style.transform = this.openValue ? "rotate(180deg)" : "rotate(0deg)"
      this.chevronTarget.style.transition = "transform 200ms ease"
    }
  }
}
