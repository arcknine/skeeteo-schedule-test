class Schedule::Regular < Schedule
  belongs_to :route, optional: false

  before_save :remove_empty_or_blank_days
  before_save :validate_conflicted_schedules

  validates :days, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  alias_attribute :departure_time, :start_time
  alias_attribute :arrival_time, :end_time

  def is_active?
    true
  end

  def nice_day_format_to_s
    self.days.map { |d| Schedule::DAYS[d] }.join(", ")
  end

  def build_hash
    {
      groupId: self.id,
      title: "R##{self.route.id} (#{self.route.origin} - #{self.route.destination})",
      daysOfWeek: self.days,
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

  def validate_conflicted_schedules
    # code here to valide conflicted schedules
  end
end
