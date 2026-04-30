class Activity < ApplicationRecord
  belongs_to :parking_spot

  validates :event_type, :from_status, :to_status, presence: true

  scope :recent, ->(limit = 20) { order(created_at: :desc).limit(limit) }
end
