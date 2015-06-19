module PlanForecast
  extend ActiveSupport::Concern

  def similar_plans
    result = []
    result << Plan.first
  end
end