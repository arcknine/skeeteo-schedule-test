class Route < ApplicationRecord
  belongs_to :vessel
  has_many :schedules, dependent: :destroy

  def metric_distance
    "#{self.distance} KM"
  end
end
