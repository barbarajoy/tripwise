class RemoveValidateFromTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :validate, :boolean
  end
end
