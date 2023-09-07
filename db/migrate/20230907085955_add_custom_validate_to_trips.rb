class AddCustomValidateToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :custom_validate, :boolean
  end
end
