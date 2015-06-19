class PlanSheet
  include ActiveModel::Model

  attr_accessor :days,
                :begin_date,
                :end_date,
                :stations,
                :plans

  def initialize(params = {})
    params.each { |key, value| send "#{key}=", value }
  end

  def days
    @days ||= 1
  end

  def begin_date
    @begin_date ||= Plan.last_date + 1.day
  end

  def end_date
    @end_date ||= begin_date + (days.to_i - 1).days
  end

  def stations
    @stations ||= Station.all
  end

  def plans
    @end_date ||= []
  end
end