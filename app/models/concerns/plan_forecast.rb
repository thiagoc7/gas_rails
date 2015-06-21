module PlanForecast
  extend ActiveSupport::Concern

  def similar_plans
    result = []
    result << last_similar << last_last_similar << average_similar
    # result + important_similar if important?
  end

  private
  def last_similar
    plan = find_similar(7)
    format_similar plan, plan.date
  end

  def last_last_similar
    plan = find_similar(14)
    format_similar plan, plan.date
  end

  def average_similar
    result_hash = {}
    station.tanks.each { |tank| result_hash[tank.gasoline] = 0 }
    dates = [date_ago(7), date_ago(14), date_ago(21), date_ago(28), date_ago(35)]

    Plan.where(date: dates, station: station).each do |plan|
      plan.measures.each do |measure|
        result_hash[measure.tank.gasoline] += measure.sell_volume
        puts result_hash[measure.tank.gasoline]
        puts measure.sell_volume
      end
    end

    result = ['Média 5', '']
    result_hash.each do |key, value|
      result << value / 5
    end
    result
  end

  def important_similar

  end

  def find_similar(days_ago)
    search_date = date_ago(days_ago)
    Plan.find_by(date: search_date, station: station)
  end

  def format_similar(plan, description)
    result = [description, plan.events.join(', ')]
    plan.measures.each do |measure|
      result << measure.sell_volume
    end
    result
  end

  def date_ago(days_ago)
    date - days_ago.days
  end
end