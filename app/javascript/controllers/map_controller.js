import { Controller } from "@hotwired/stimulus"
import * as L from "leaflet"

export default class extends Controller {
  static values = {
    spots:  { type: Array,  default: [] },
    center: { type: Object, default: { lat: 59.3293, lng: 18.0686, zoom: 13 } }
  }

  connect() {
    this.map = L.map(this.element, {
      zoomControl: false,
      attributionControl: true
    }).setView([this.centerValue.lat, this.centerValue.lng], this.centerValue.zoom)

    L.control.zoom({ position: "bottomleft" }).addTo(this.map)

    L.tileLayer("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png", {
      maxZoom: 20,
      subdomains: "abcd",
      attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="https://carto.com/attributions">CARTO</a>'
    }).addTo(this.map)

    this.markersById = new Map()
    this.spotsValue.forEach(spot => this.addMarker(spot))

    this.activeFilters = {
      "status:available": true,
      "status:occupied": true,
      "status:reserved": true,
      "status:out_of_service": true,
      "type:ev_charging": false,
      "type:accessible": false
    }

    requestAnimationFrame(() => this.map.invalidateSize())
    setTimeout(() => this.map.invalidateSize(), 200)

    this.resizeObserver = new ResizeObserver(() => {
      if (this.map) this.map.invalidateSize()
    })
    this.resizeObserver.observe(this.element)
  }

  disconnect() {
    if (this.resizeObserver) this.resizeObserver.disconnect()
    if (this.map) this.map.remove()
  }

  addMarker(spot) {
    const isEV = spot.type === "ev_charging"
    const html = `<span class="pin ${isEV ? 'is-ev' : ''}" style="background:${spot.color}"></span>`
    const icon = L.divIcon({
      className: "parking-marker",
      html,
      iconSize: [16, 16],
      iconAnchor: [8, 8]
    })
    const marker = L.marker([spot.lat, spot.lng], { icon })
    marker.bindTooltip(`${spot.identifier}`, { direction: "top", offset: [0, -8] })
    marker.on("click", () => this.openSpot(spot))
    marker.addTo(this.map)
    marker._spot = spot
    this.markersById.set(spot.id, marker)
  }

  openSpot(spot) {
    const frame = document.getElementById("spot_detail")
    if (frame) frame.src = spot.url
  }

  updateMarker(event) {
    const { id, status, color } = event.detail
    const marker = this.markersById.get(parseInt(id))
    if (!marker) return

    marker._spot.status = status
    marker._spot.color = color

    const el = marker.getElement()
    if (el) {
      const pin = el.querySelector(".pin")
      if (pin) {
        pin.style.background = color
        pin.style.transition = "background 400ms ease, transform 250ms ease"
        pin.style.transform = "scale(1.6)"
        setTimeout(() => { pin.style.transform = "scale(1)" }, 250)
      }
    }

    const visible = this.spotMatches(marker._spot)
    const onMap = this.map.hasLayer(marker)
    if (visible && !onMap) marker.addTo(this.map)
    if (!visible && onMap) this.map.removeLayer(marker)
  }

  applyFilter(event) {
    this.activeFilters = { ...this.activeFilters, ...event.detail }
    this.markersById.forEach((marker) => {
      const spot = marker._spot
      const visible = this.spotMatches(spot)
      const onMap = this.map.hasLayer(marker)
      if (visible && !onMap) marker.addTo(this.map)
      if (!visible && onMap) this.map.removeLayer(marker)
    })
  }

  flyTo(event) {
    const { lat, lng, zoom } = event.detail
    if (!this.map) return
    this.map.flyTo([lat, lng], zoom || 15, { duration: 0.8 })
  }

  spotMatches(spot) {
    const statusKey = `status:${spot.status}`
    if (this.activeFilters[statusKey] === false) return false

    const evOnly = this.activeFilters["type:ev_charging"]
    const accOnly = this.activeFilters["type:accessible"]
    if (evOnly && spot.type !== "ev_charging") return false
    if (accOnly && spot.type !== "accessible") return false

    return true
  }
}
