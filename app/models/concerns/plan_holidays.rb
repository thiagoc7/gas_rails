module PlanHolidays
  extend ActiveSupport::Concern

  included do
    before_save :set_holiday, :set_day_of_week, :set_date_type

    enum holiday_reference: %w(véspera pós-feriado)
    enum date_type: %w(fraco forte)
    enum day_of_week: %w(Domingo Segunda Terça Quarta Quinta Sexta Sábado)
  end

  def weekend?
    date.saturday? || date.sunday?
  end

  def events
    result = []
    result << holiday if holiday
    result << holiday_reference if holiday_reference
    result << date_type if date_type
    result
  end

  def wday_to_i
    Plan.day_of_weeks[day_of_week]
  end

  def date_type_to_i
    Plan.date_types[date_type]
  end

  def holiday_ref_to_i
    Plan.holiday_references[holiday_reference]
  end

  private
  def set_day_of_week
    self.day_of_week ||= date.wday
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

  def set_date_type
    (date.month == date.next_day.month) ? day = date.day : day = 0
    if station.strong_array.include? day
      self.date_type = 1
    elsif station.weak_array.include? day
      self.date_type = 0
    end
  end
end