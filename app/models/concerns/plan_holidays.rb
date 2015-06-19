module PlanHolidays
  extend ActiveSupport::Concern

  included do
    before_create :set_day_of_week, :set_holiday
    enum holiday_reference: %w(before after)
    enum date_type: %w(weak strong)
  end

  # for self. methods
  # module ClassMethods
  # end

  private
  def set_day_of_week
    self.day_of_week ||= date.strftime("%A")
    # if day_of_week == 'Saturday' || day_of_week == 'Sunday'
    #   self.business_day = false
    # end
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
      self.holiday_reference = 0
    elsif date.yesterday.holiday?(:br)
      self.holiday_reference = 1
    end
  end
end