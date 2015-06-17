require 'test_helper'

class StationTest < ActiveSupport::TestCase
  def setup
    @station = stations(:oliveira)
  end

  test "require name" do
    assert @station.valid?

    @station.name = nil
    assert @station.invalid?, 'station require a name'
  end

  test "has many tanks" do
    assert_equal @station.tanks.size, 4
  end

  test "accept nest tanks" do
    new_station = Station.new(name: 'station')
    new_station.tanks << Tank.new(gasoline: 'XXX', capacity: 1000.00)
    new_station.tanks << Tank.new(gasoline: 'YYY', capacity: 1000.00)
    assert new_station.save!
    assert_equal new_station.tanks.size, 2
  end
end
