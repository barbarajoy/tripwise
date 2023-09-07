class AddValidateToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :validate, :boolean, default: false
  end
end
