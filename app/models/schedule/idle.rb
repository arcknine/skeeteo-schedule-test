class Schedule::Idle < Schedule
  def no_travel_date
    self.date
  end
end
