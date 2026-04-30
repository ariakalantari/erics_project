import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    lat: Number,
    lng: Number,
    url: String
  }

  flyTo() {
    window.dispatchEvent(new CustomEvent("map:fly-to", {
      detail: { lat: this.latValue, lng: this.lngValue, zoom: 19 }
    }))
    if (this.hasUrlValue) {
      const frame = document.getElementById("spot_detail")
      if (frame) frame.src = this.urlValue
    }
  }
}
