class RemovePositionFromDestinationsAndAddToTripDestinations < ActiveRecord::Migration[6.0]
  def change
    remove_column :destinations, :position, :integer
    add_column :trip_destinations, :position, :integer
  end
end
