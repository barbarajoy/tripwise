class CreateTripsDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :trips_destinations do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true

      t.timestamps
    end
  end
end
