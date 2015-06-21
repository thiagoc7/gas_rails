class Measure < ActiveRecord::Base
  belongs_to :plan, touch: true
  belongs_to :tank
  default_scope { order('tank_id') }

  validates_presence_of :plan, :tank
  validates_uniqueness_of :tank, scope: :plan

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
end
