class MakeTripperIdNullableInTrips < ActiveRecord::Migration[6.0]
  def change
    change_column_null :trips, :tripper_id, true
  end
end
