class AddBudgetToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :budget, :integer, default: 10
  end
end
