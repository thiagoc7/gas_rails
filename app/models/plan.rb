class Plan < ActiveRecord::Base
  belongs_to :station
  has_many :measures, inverse_of: :plan

  validates_uniqueness_of :date, scope: :station

  accepts_nested_attributes_for :measures

  include PlanHolidays
  include PlanMeasures
  include PlanBuySuggestion
  include PlanForecast
  include PlanCreate

  def self.last_date
    Plan.order('date DESC').first.date
  end

  def self.between_dates(from, to)
    where(date: from..to)
  end

  def self.open_plans
    where(finished: false).order('station_id, date')
  end

  def important?
    date_type || holiday || holiday_reference
  end
end
