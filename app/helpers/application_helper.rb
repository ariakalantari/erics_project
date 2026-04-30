module ApplicationHelper
  STATUS_ICONS = {
    "available"      => "circle-check",
    "occupied"       => "circle",
    "reserved"       => "clock",
    "out_of_service" => "ban"
  }.freeze

  def status_icon(status)
    STATUS_ICONS.fetch(status.to_s, "circle")
  end
end
