module PlanCreate
  extend ActiveSupport::Concern

  module ClassMethods
    def create_plans(station_id, begin_date = Date.tomorrow, end_date = nil)
      result = []
      end_date ||= begin_date

      (begin_date.to_date..end_date.to_date).each do |date|
        result << Plan.find_or_create_by(date: date, station_id: station_id)
      end
      result
    end

    def create_plans_for_all(begin_date = Date.tomorrow, end_date = nil)
      result = []
      Station.all.each do |station|
        result += Plan.create_plans(station.id, begin_date, end_date)
      end
      result
    end

    def create_next_plans
      date = Plan.last_date + 1.day
      create_plans_for_all(date)
      Plan.open_plans
    end
  end
end