class Schedule::Idle < Schedule
  validates :date, presence: true

  alias_attribute :idle_date, :date

  def build_hash
    {
      title: "No Travel (#{self.remarks})",
      start: self.start_time ? self.start_datetime : self.date,
      end: self.end_time ? self.start_datetime : self.date,
      color: 'purple'
    }
  end
end
