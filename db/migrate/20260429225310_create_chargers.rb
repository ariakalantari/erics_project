class CreateChargers < ActiveRecord::Migration[8.1]
  def change
    create_table :chargers do |t|
      t.references :parking_spot, null: false, foreign_key: true, index: { unique: true }
      t.integer :power_kw, null: false
      t.integer :connector_type, null: false, default: 0
      t.decimal :price_per_kwh, precision: 6, scale: 2, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
