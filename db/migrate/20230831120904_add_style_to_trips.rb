class AddStyleToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :style, :string
  end
end
