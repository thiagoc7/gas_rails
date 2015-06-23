class Supplier < ActiveRecord::Base
  has_many :prices
  validates_presence_of :name
end
