class Price < ActiveRecord::Base
  belongs_to :supplier
  validates_presence_of :gasoline, :amount, :supplier
end
