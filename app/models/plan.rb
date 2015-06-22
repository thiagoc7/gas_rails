class Plan < ActiveRecord::Base
  belongs_to :station
  has_many :measures

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
    includes(:station).where(date: from..to)
  end

  def self.open_plans
    includes(:station).where(finished: false).order('station_id, date')
  end

  def self.last_of_kind(limit)
    order('date DESC').limit(limit)
  end

  def self.similars(station)
    where(station: station, day_of_week: day_of_week)
  end

  def important?
    date_type || holiday || holiday_reference
  end

  def cached_measures
    Rails.cache.fetch([self.class.name, id, :measures], expires_in: 240.hours) { measures.to_a }
  end
end
