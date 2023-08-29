class AddTripToTrips < ActiveRecord::Migration[7.0]
  def change
    add_reference :trips, :trip, foreign_key: { to_table: :trips }
  end
end
