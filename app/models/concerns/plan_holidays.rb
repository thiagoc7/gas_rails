module PlanHolidays
  extend ActiveSupport::Concern

  included do
    before_create :set_day_of_week, :set_holiday
  end

  # for self. methods
  # module ClassMethods
  # end

  private
  def set_day_of_week
    self.day_of_week ||= date.strftime("%A")
  end

  def set_holiday
    if date.holiday?(:br)
      self.holiday = date.holidays(:br)[0][:name]
    else
      set_day_before
    end
  end

  def set_day_before
    if date.tomorrow.holiday?(:br)
      self.day_before = true
      self.holiday = date.tomorrow.holidays(:br)[0][:name]
    end
  end
end