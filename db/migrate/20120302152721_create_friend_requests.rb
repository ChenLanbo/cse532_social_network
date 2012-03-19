class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :user_id
      t.integer :requester_id

      t.timestamps
    end

		execute <<-SQL
			ALTER TABLE friend_requests
				ADD CONSTRAINT fk1_friend_requests
					FOREIGN KEY (user_id) REFERENCES users(id),
				ADD CONSTRAINT fk2_friend_requests
					FOREIGN KEY (requester_id) REFERENCES users(id)
		SQL
  end
end
