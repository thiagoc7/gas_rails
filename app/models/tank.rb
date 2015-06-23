class Tank < ActiveRecord::Base
  belongs_to :station
  has_many :measures
  validates_presence_of :station, :capacity, :gasoline, :max_volume, :min_volume, :number
  validates_uniqueness_of :gasoline, scope: :station

  after_commit :flush_cache

  private
  def flush_cache
    Rails.cache.delete([:tank, self.id])
  end
end
