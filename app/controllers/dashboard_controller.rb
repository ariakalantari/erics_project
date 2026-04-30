class DashboardController < ApplicationController
  STOCKHOLM_CENTER = { lat: 59.3293, lng: 18.0686, zoom: 13 }.freeze

  def index
    @parking_areas = ParkingArea.includes(:parking_spots).order(:name)
    @spots = ParkingSpot.includes(:parking_area, :charger).order(:identifier)

    @stats = {
      available: ParkingSpot.available.count,
      total:        @spots.size,
      ev_total:     @spots.count { |s| s.ev_charging? },
      ev_available: @spots.count { |s| s.ev_charging? && s.available? }
    }

    @spots_json = @spots.map { |s|
      {
        id:         s.id,
        identifier: s.identifier,
        lat:        s.lat.to_f,
        lng:        s.lng.to_f,
        status:     s.status,
        type:       s.spot_type,
        area:       s.parking_area.name,
        color:      s.status_color,
        url:        parking_spot_path(s)
      }
    }

    @recent_activities = Activity.includes(parking_spot: :parking_area).recent(20)

    @map_center = STOCKHOLM_CENTER
  end
end
