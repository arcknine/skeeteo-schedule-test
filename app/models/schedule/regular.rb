class Schedule::Regular < Schedule
  before_save :remove_empty_or_blank_days
  before_save :position_set_to_first
  before_save :validate_conflicted_schedules

  validates :days, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  alias_attribute :departure_time, :start_time
  alias_attribute :arrival_time, :end_time

  FULLCALENDAR = {
    'U' => 0,
    'M' => 1,
    'T' => 2,
    'W' => 3,
    'R' => 4,
    'F' => 5,
    'S' => 6
  }

  def is_active?
    true
  end

  def build_hash
    {
      groupId: self.id,
      title: "R##{self.route.id} (#{self.route.origin} - #{self.route.destination})",
      daysOfWeek: self.days.map { |d| Schedule::Regular::FULLCALENDAR[d] },
      startTime: self.start_time.strftime("%I:%M:%S %P"),
      endTime: self.end_time.strftime("%I:%M:%S %P"),
      color: 'blue'
    }
  end

  private

  def remove_empty_or_blank_days
    return if self.days.empty? || self.days.blank?
    self.days.reject!(&:blank?).reject!(&:empty?)
  end

  def position_set_to_first
    self.position = 1
  end

  def validate_conflicted_schedules
    false
  end
end
