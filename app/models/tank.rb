class Tank < ActiveRecord::Base
  belongs_to :station
  has_many :measures
  validates_presence_of :station, :capacity, :gasoline
  validates_uniqueness_of :gasoline, scope: :station
end
