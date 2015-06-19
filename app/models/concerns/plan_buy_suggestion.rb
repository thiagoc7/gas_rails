module PlanBuySuggestion
  extend ActiveSupport::Concern

  def suggest_buy_volumes
    result = []
    result << Plan.last
  end
end