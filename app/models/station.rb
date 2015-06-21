class Station < ActiveRecord::Base
  has_many :tanks
  has_many :plans

  validates_presence_of :name
  validates_uniqueness_of :name

  def weak_array
    weak_days.to_s.split(',').map { |v| v.to_i }
  end

  def strong_array
    strong_days.to_s.split(',').map { |v| v.to_i }
  end
end
