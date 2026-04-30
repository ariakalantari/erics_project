import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.handler = this.recompute.bind(this)
    window.addEventListener("spot:status-changed", this.handler)
  }

  disconnect() {
    window.removeEventListener("spot:status-changed", this.handler)
  }

  recompute() {
    const states = document.querySelectorAll("[data-spot-id]")
    let total = 0, available = 0, evTotal = 0, evAvailable = 0

    states.forEach((el) => {
      total++
      const isAvail = el.dataset.status === "available"
      const isEV    = el.dataset.type === "ev_charging"
      if (isAvail) available++
      if (isEV) {
        evTotal++
        if (isAvail) evAvailable++
      }
    })

    const pct   = total ? Math.round(available / total * 100) : 0
    const evPct = evTotal ? Math.round(evAvailable / evTotal * 100) : 0

    this.set("stat-available", available)
    this.set("stat-percent", pct)
    this.set("stat-ev-available", evAvailable)
    this.set("stat-ev-percent", evPct)

    const bar = document.getElementById("stat-bar")
    if (bar) bar.style.width = `${pct}%`
  }

  set(id, value) {
    const el = document.getElementById(id)
    if (!el) return
    if (el.textContent !== String(value)) {
      el.textContent = value
      el.style.transition = "color 250ms ease"
      el.style.color = "#10b981"
      setTimeout(() => { el.style.color = "" }, 350)
    }
  }
}
