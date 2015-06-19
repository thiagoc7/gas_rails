module PlanMeasures
  extend ActiveSupport::Concern

  included do
    after_save :create_measures
  end

  # for self. methods
  # module ClassMethods
  # end

  private
  def create_measures
    self.station.tanks.each do |tank|
      Measure.find_or_create_by(tank: tank, plan: self)
    end
  end
end