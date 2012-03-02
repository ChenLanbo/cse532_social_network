class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.integer :day_of_birth
      t.integer :month_of_birth
      t.integer :year_of_birth
      t.string :gender
      t.string :address

      t.timestamps
    end
  end
end
