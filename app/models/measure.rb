class Measure < ActiveRecord::Base
  belongs_to :plan, inverse_of: :measures
  belongs_to :tank
  default_scope { order('tank_id') }

  validates_presence_of :plan, :tank
  validates_uniqueness_of :tank, scope: :plan

  # before_save :adjust_integers

  include MeasuresImport

  attr_accessor :initial_volume,
                :sell_volume,
                :forecast_final_volume

  def initial_volume
    date = plan.date - 1.day
    yesterday_plan = Plan.where(date: date, station: plan.station).first
    measure = Measure.where(plan: yesterday_plan, tank: tank).first
    measure ? measure.final_volume || measure.forecast_final_volume : 0
  end

  def sell_volume
    final_volume ? initial_volume + buy_volume - final_volume : 0
  end

  def forecast_final_volume
    initial_volume + buy_volume - forecast_volume
  end

  private
  def adjust_integers
    self.final_volume = string_to_integer(final_volume)
    self.forecast_volume = string_to_integer(forecast_volume)
    self.buy_volume = string_to_integer(buy_volume)
  end

  def string_to_integer(number)
    if number
      number.to_s.gsub('.', '').to_i
    else
      nil
    end
  end

end
