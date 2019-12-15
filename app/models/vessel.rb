class Vessel < ApplicationRecord
  has_many :routes, dependent: :destroy
  has_many :schedules

  validates :name, presence: true

  def status
    return 'Decommissioned' if self.decommissioned?
    return 'Maintenance' if check_if_under_maintenance?
    'Active'
  end

  private

  def check_if_under_maintenance?
    schedules = self.schedules.where(type: 'Schedule::Maintenance').where("? BETWEEN start_time AND end_time AND date >= ?", Time.now.to_s, Date.today).count
    schedules > 0
  end
end
