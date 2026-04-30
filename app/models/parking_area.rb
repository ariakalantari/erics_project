class ParkingArea < ApplicationRecord
  has_many :parking_spots, dependent: :destroy
  has_many :chargers, through: :parking_spots

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :lng, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  def available_count
    parking_spots.available.count
  end

  def total_count
    parking_spots.count
  end

  def occupancy_ratio
    return 0.0 if total_count.zero?
    1.0 - (available_count.to_f / total_count)
  end
end
