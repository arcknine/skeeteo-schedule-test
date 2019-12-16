class Schedule::Maintenance < Schedule
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true

  alias_attribute :maintenance_date, :date

  def build_hash
    {
      title: 'Maintenance',
      start: self.start_datetime,
      end: self.end_datetime,
      color: 'orange',
      overlap: true,
    }
  end
end
