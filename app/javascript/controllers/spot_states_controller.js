import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.handleStream = this.handleStream.bind(this)
    document.addEventListener("turbo:before-stream-render", this.handleStream)
  }

  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.handleStream)
  }

  handleStream(event) {
    const stream = event.target
    if (!stream || stream.action !== "replace") return

    const targetId = stream.target
    if (!targetId || !targetId.startsWith("spot_state_")) return

    const template = stream.querySelector("template")
    if (!template) return

    const newEl = template.content.querySelector("[data-spot-id]")
    if (!newEl) return

    window.dispatchEvent(new CustomEvent("spot:status-changed", {
      detail: {
        id:     newEl.dataset.spotId,
        status: newEl.dataset.status,
        color:  newEl.dataset.color
      }
    }))
  }
}
