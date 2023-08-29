class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.integer :longitude
      t.integer :latitude
      t.string :address
      t.string :description
      t.integer :position

      t.timestamps
    end
  end
end
