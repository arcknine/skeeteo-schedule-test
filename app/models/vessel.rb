class Vessel < ApplicationRecord
  has_many :routes, dependent: :destroy
  has_many :schedules

  def status
    return 'Decommissioned' if self.decommissioned?

    'Active'
  end
end
