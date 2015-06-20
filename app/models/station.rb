class Station < ActiveRecord::Base
  validates_presence_of :name

  has_many :tanks
  has_many :plans

  def weak_array
    weak_days.to_s.split(',').map { |v| v.to_i }
  end

  def strong_array
    strong_days.to_s.split(',').map { |v| v.to_i }
  end
end
