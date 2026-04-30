class CreateParkingAreas < ActiveRecord::Migration[8.1]
  def change
    create_table :parking_areas do |t|
      t.string :name, null: false
      t.text :description
      t.string :address
      t.string :city, null: false, default: "Stockholm"
      t.decimal :lat, precision: 10, scale: 7, null: false
      t.decimal :lng, precision: 10, scale: 7, null: false

      t.timestamps
    end

    add_index :parking_areas, :name, unique: true
  end
end
