class Charger < ApplicationRecord
  belongs_to :parking_spot

  enum :connector_type, { type2: 0, ccs: 1, chademo: 2 }
  enum :status,         { idle: 0, in_use: 1, faulted: 2 }

  validates :power_kw, presence: true, numericality: { greater_than: 0 }
  validates :price_per_kwh, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def display_connector
    case connector_type
    when "type2"   then "Type 2"
    when "ccs"     then "CCS"
    when "chademo" then "CHAdeMO"
    end
  end
end
