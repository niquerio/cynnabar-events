class CreateMetaEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :meta_events do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
  end
end
