class ChangeLongitudeAndLatitudeToFloatInDestinations < ActiveRecord::Migration[6.0]
  def change
    change_column :destinations, :longitude, :float
    change_column :destinations, :latitude, :float
  end
end
