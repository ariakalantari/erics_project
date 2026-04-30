class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.references :parking_spot, null: false, foreign_key: true
      t.string :event_type, null: false, default: "status_changed"
      t.string :from_status, null: false
      t.string :to_status, null: false

      t.timestamps
    end

    add_index :activities, :created_at
  end
end
