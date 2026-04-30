class ParkingSpot < ApplicationRecord
  belongs_to :parking_area
  has_one :charger, dependent: :destroy
  has_many :activities, dependent: :destroy

  enum :spot_type, { standard: 0, ev_charging: 1, accessible: 2, motorcycle: 3, loading: 4 }
  enum :status,    { available: 0, occupied: 1, reserved: 2, out_of_service: 3 }

  validates :identifier, presence: true, uniqueness: true
  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :lng, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validate :charger_only_for_ev_spots

  scope :with_charger, -> { includes(:charger) }

  after_update_commit :record_status_change, if: :saved_change_to_status?

  STATUS_COLORS = {
    "available"      => "#10b981",
    "occupied"       => "#a1a1aa",
    "reserved"       => "#f59e0b",
    "out_of_service" => "#ef4444"
  }.freeze

  def status_color
    STATUS_COLORS[status]
  end

  def display_status
    status.tr("_", " ").capitalize
  end

  def display_type
    case spot_type
    when "ev_charging"    then "EV Charging"
    when "out_of_service" then "Out of Service"
    else spot_type.tr("_", " ").capitalize
    end
  end

  private

  def record_status_change
    from, to = saved_change_to_status
    activity = activities.create!(event_type: "status_changed", from_status: from, to_status: to)

    broadcast_replace_to "spots",
      target:  "spot_state_#{id}",
      partial: "dashboard/spot_state",
      locals:  { spot: self }
    broadcast_prepend_to "activity",
      target:  "activity_feed",
      partial: "dashboard/activity_entry",
      locals:  { activity: activity }
  end

  def charger_only_for_ev_spots
    if charger.present? && !ev_charging?
      errors.add(:charger, "can only be attached to EV charging spots")
    end
  end
end
