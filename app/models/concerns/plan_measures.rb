module PlanMeasures
  extend ActiveSupport::Concern

  included do
    after_save :create_measures
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
    cached_measures.each do |measure|
      result[:labels] << measure.cached_tank.gasoline
      result[:initial_volume] << initial_volume_build(measure)
      result[:buy_volume] << measure.buy_volume
      result[:sell_volume] << measure.sell_volume
      result[:forecast_volume] << measure.forecast_volume
      result[:final_volume] << measure.final_volume
      result[:forecast_final_volume] << forecast_final_volume_build(measure)
      result[:prices] << measure.prices
    end
    result
  end

  def initial_volume_build(measure)
    initial = measure.initial_volume
    return [0, ''] unless initial
    class_name = 'light-green-text darken-1'
    class_name = 'deep-orange-text darken-1' if initial.to_i + measure.buy_volume.to_i > measure.cached_tank.max_volume.to_i
    [initial, class_name]
  end

  def forecast_final_volume_build(measure)
    final = measure.forecast_final_volume
    # return [0, ''] unless final
    class_name = 'light-green-text darken-1'
    class_name = 'deep-orange-text darken-1' if final.to_i + measure.buy_volume.to_i < measure.cached_tank.min_volume.to_i
    [final, class_name]
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
        prices: []
    }
  end

  def create_measures
    self.station.tanks.each do |tank|
      Measure.find_or_create_by(tank: tank, plan: self)
    end
  end
end