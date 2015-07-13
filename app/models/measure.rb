class Measure < ActiveRecord::Base
  belongs_to :plan, touch: true
  belongs_to :tank
  default_scope { joins(:tank).order('tanks.gasoline') }

  validates_presence_of :plan, :tank
  validates_uniqueness_of :tank, scope: :plan

  after_commit :flush_cache

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
    initial_volume.to_i + buy_volume.to_i - forecast_volume.to_i
  end

  def cached_tank
    Rails.cache.fetch([:tank, tank.id], expires_in: 24.hours) { tank }
  end

  def prices
    result = {}
    Price.includes(:supplier).where(gasoline: tank.gasoline).each do |price|
      result[price.supplier.name] = price.amount.gsub(',', '.').to_i.to_f * buy_volume.to_i.to_f
    end
    result.sort_by(&:last).to_h
  end

  private
  def flush_cache
    Rails.cache.delete([self.plan.class.name, self.plan_id, :measures])
  end
end
