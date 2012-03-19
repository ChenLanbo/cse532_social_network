class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :fu_id

      t.timestamps
    end

		execute <<-SQL
			ALTER TABLE friends
				ADD CONSTRAINT fk1_friends
					FOREIGN KEY (user_id) REFERENCES users(id),
				ADD CONSTRAINT fk2_friends
					FOREIGN KEY (fu_id) REFERENCES users(id)
		SQL
  end
end
