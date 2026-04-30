import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  dismiss() {
    const frame = document.getElementById("spot_detail")
    if (frame) {
      frame.removeAttribute("src")
      frame.innerHTML = ""
    }
  }
}
