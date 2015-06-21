module PlanForecast
  extend ActiveSupport::Concern

  def similar_plans
    return regular_similar.sort_by &:date unless important?
    build_important.sort_by &:date
  end

  private
  def build_important
    if holiday
      result = holiday_similar
    elsif holiday_reference
      result = holiday_references_similar
    else
      result = date_type_similar
    end
    result + regular_similar(2)
  end

  def regular_similar(limit = 4)
    puts day_of_week
    puts wday_to_i
    Plan.where(station: station,
               finished: true,
               day_of_week: wday_to_i,
               date_type: nil,
               holiday_reference: nil,
               holiday: nil).order('date DESC').limit(limit)
  end

  def holiday_similar
    Plan.where.not(holiday: nil).where(station: station,
                                       finished: true,
                                       day_of_week: wday_to_i).order('date DESC').limit(4)
  end

  def date_type_similar
    Plan.where(station: station,
               finished: true,
               date_type: date_type_to_i,
               holiday: nil).order('date DESC').limit(4)
  end

  def holiday_references_similar
    Plan.where(station: station,
               finished: true,
               holiday_reference: holiday_ref_to_i,
               day_of_week: wday_to_i,
               holiday: nil).order('date DESC').limit(4)
  end
end