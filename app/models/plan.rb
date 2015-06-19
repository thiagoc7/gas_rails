class Plan < ActiveRecord::Base
  belongs_to :station
  has_many :measures

  validates_uniqueness_of :date, scope: :station

  attr_accessor :fresh
  after_find :set_finished

  accepts_nested_attributes_for :measures

  include PlanHolidays
  include PlanMeasures
  include PlanBuySuggestion
  include PlanForecast

  def self.create_plans(station_id, begin_date = Date.tomorrow, end_date = nil)
    result = []
    end_date ||= begin_date

    (begin_date.to_date..end_date.to_date).each do |date|
      result << Plan.find_or_create_by(date: date, station_id: station_id)
    end
    result
  end

  def self.last_date
    Plan.order('date DESC').first.date
  end

  def self.between_dates(from, to)
    where(date: from..to).order('date DESC')
  end

  private
  def set_finished
    return if self.finished?
    result = true
    measures.each do |m|
      result = false unless m.final_volume
    end
    self.finished = result
  end
end
