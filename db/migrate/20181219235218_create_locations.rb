class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :event, foreign_key: true
      t.string :name
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
