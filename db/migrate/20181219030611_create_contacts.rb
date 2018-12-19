class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :event, foreign_key: true
      t.string :name
      t.string :job
      t.string :email

      t.timestamps
    end
  end
end
