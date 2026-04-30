class CreateParkingSpots < ActiveRecord::Migration[8.1]
  def change
    create_table :parking_spots do |t|
      t.references :parking_area, null: false, foreign_key: true
      t.string :identifier, null: false
      t.decimal :lat, precision: 10, scale: 7, null: false
      t.decimal :lng, precision: 10, scale: 7, null: false
      t.integer :spot_type, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :parking_spots, :identifier, unique: true
    add_index :parking_spots, :status
    add_index :parking_spots, :spot_type
  end
end
