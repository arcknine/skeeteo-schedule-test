class Route < ApplicationRecord
  belongs_to :vessel
  has_many :schedules, dependent: :destroy

  validates_presence_of :name, :distance, :origin, :destination

  def metric_distance
    "#{self.distance} KM"
  end
end
