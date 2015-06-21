module PlanMeasures
  extend ActiveSupport::Concern

  included do
    after_save :create_measures
    # attr_accessor :measures_hash
  end

  # for self. methods
  # module ClassMethods
  # end

  def measures_hash
    @measures_hash ||= measures_hash_build
  end

  private
  def measures_hash_build
    result = measures_hash_base
    measures.each do |measure|
      result[:labels] << measure.tank.gasoline
      result[:initial_volume] << measure.initial_volume
      result[:buy_volume] << measure.buy_volume
      result[:sell_volume] << measure.sell_volume
      result[:forecast_volume] << measure.forecast_volume
      result[:final_volume] << measure.final_volume
      result[:forecast_final_volume] << measure.forecast_final_volume
    end
    result
  end

  def measures_hash_base
    {
        labels: [],
        initial_volume: [],
        buy_volume: [],
        sell_volume: [],
        forecast_volume: [],
        final_volume: [],
        forecast_final_volume: [],
    }
  end

  def create_measures
    self.station.tanks.each do |tank|
      Measure.find_or_create_by(tank: tank, plan: self)
    end
  end
end