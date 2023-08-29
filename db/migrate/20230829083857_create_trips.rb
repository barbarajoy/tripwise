class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :planner, foreign_key: { to_table: :users }
      t.references :tripper, foreign_key: { to_table: :users }
      t.string :title
      t.string :image_url
      t.text :comment

      t.timestamps
    end
  end
end
