class Tank < ActiveRecord::Base
  validates_presence_of :station, :capacity
  belongs_to :station
  has_many :measures
end
