class Vessel < ApplicationRecord
  has_many :routes, dependent: :destroy

  def status
    return 'Decommissioned' if self.decommissioned?

    'Active'
  end
end
