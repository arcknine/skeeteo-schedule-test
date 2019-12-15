class Schedule::Special < Schedule
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true

  alias_attribute :departure_date, :date

  def build_hash
    {
      title: "#{self.route.origin} - #{self.route.destination}",
      start: self.start_datetime,
      end: self.start_datetime,
      color: 'green'
    }
  end
end
