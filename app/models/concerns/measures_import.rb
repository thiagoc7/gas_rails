module MeasuresImport
  extend ActiveSupport::Concern

  included do
    require 'csv'
  end

  # date, final_volume, buy_volume
  module ClassMethods
    def import(file, station_id, gasoline)
      file = file.path unless file.is_a? String
      tank = Tank.find_by(station_id: station_id, gasoline: gasoline)

      CSV.foreach(file, headers: true) do |row|
        hash = row.to_hash.symbolize_keys!
        plan = Plan.find_or_create_by(date: hash[:date].to_date, station_id: station_id)
        hash.delete(:date)
        Measure.find_or_initialize_by(plan: plan, tank: tank).update!(final_volume: hash[:final_volume], buy_volume: hash[:buy_volume])
      end
    end
  end
end