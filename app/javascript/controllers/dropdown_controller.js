import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.outsideClickHandler = this.handleOutsideClick.bind(this)
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClickHandler)
  }

  toggle(event) {
    if (event) event.stopPropagation()
    const willOpen = this.menuTarget.hidden
    this.menuTarget.hidden = !willOpen
    if (willOpen) {
      setTimeout(() => document.addEventListener("click", this.outsideClickHandler), 0)
    } else {
      document.removeEventListener("click", this.outsideClickHandler)
    }
  }

  close() {
    this.menuTarget.hidden = true
    document.removeEventListener("click", this.outsideClickHandler)
  }

  flyTo(event) {
    const lat  = parseFloat(event.params.lat)
    const lng  = parseFloat(event.params.lng)
    const zoom = parseFloat(event.params.zoom) || 15
    window.dispatchEvent(new CustomEvent("map:fly-to", { detail: { lat, lng, zoom } }))
    this.close()
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}
