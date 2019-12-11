class Schedule::Regular < Schedule
  def departure_time
    self.start_time
  end

  def arrival_time
    self.end_time
  end
end
