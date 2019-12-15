class Schedule < ApplicationRecord
  belongs_to :route
  belongs_to :vessel

  serialize :days, Array

  scope :active,        -> { where("(? BETWEEN start_time AND end_time AND date >= ?)  OR date >= ? OR type = ?", Time.now, Date.today, Date.today, 'Schedule::Regular') }
  scope :in_date_range, -> (start_date, end_date) { where("(date BETWEEN ? AND ?) OR type = ?", start_date, end_date, 'Schedule::Regular') }
  scope :sort_position, -> (order = 'ASC') { order("position #{order}") }

  scope :regular,     -> { where(type: 'Schedule::Regular') }
  scope :maintenance, -> { where(type: 'Schedule::Maintenance') }
  scope :special,     -> { where(type: 'Schedule::Special') }
  scope :idle,        -> { where(type: 'Schedule::Idle') }

  DAYS = {
    M: 'Monday',
    T: 'Tuesday',
    W: 'Wednesday',
    R: 'Thursday',
    F: 'Friday',
    S: 'Saturday',
    U: 'Sunday'
  }

  def is_active?
    return true if self.type == "Schedule::Regular"
    end_time_in_s    = self.end_time.present? ? self.end_time.seconds_since_midnight.seconds : DateTime.now.end_of_day.seconds_since_midnight.seconds
    (self.date.to_datetime + end_time_in_s) >= DateTime.now
  end

  def travel_code
    "V#{self.vessel_id}-R#{self.route_id}-S#{self.id}"
  end

  def start_datetime
    return self.start_time unless self.date
    self.date.to_datetime + self.start_time.seconds_since_midnight.seconds
  end

  def end_datetime
    return self.start_time unless self.date
    self.date.to_datetime + self.end_time.seconds_since_midnight.seconds
  end

  def self.parse_json_for_fullcalendar(schedules)
    schedules.map { |s| s.build_hash }
  end
end
