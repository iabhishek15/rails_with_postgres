class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hashed_password
      t.date :dob
      t.integer :mobile

      t.timestamps
    end
  end
end
