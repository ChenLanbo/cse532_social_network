class Constraints < ActiveRecord::Migration
  def up
		# Friends
		execute <<-SQL
			ALTER TABLE friends
				ADD CONSTRAINT fk1_friends
					FOREIGN KEY (user_id) REFERENCES users(id),
				ADD CONSTRAINT fk2_friends
					FOREIGN KEY (fu_id) REFERENCES users(id)
		SQL

		# FriendRequests
		execute <<-SQL
			ALTER TABLE friend_requests
				ADD CONSTRAINT fk1_friend_requests
					FOREIGN KEY (user_id) REFERENCES users(id),
				ADD CONSTRAINT fk2_friend_requests
					FOREIGN KEY (requester_id) REFERENCES users(id)
		SQL

		# Circles
		execute <<-SQL
			ALTER TABLE circles
				ADD CONSTRAINT fk_circles
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# CircleMembers
		execute <<-SQL
			ALTER TABLE circle_members
				ADD CONSTRAINT fk1_circle_members
					FOREIGN KEY (circle_id) REFERENCES circles(id),
				ADD CONSTRAINT fk2_circle_members
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# Posts
		execute <<-SQL
			ALTER TABLE posts
				ADD CONSTRAINT fk1_posts
					FOREIGN KEY (user_id) REFERENCES users(id),
				ADD CONSTRAINT fk2_posts
					FOREIGN KEY (page_id) REFERENCES pages(id)
		SQL

		# Comments
		execute <<-SQL
			ALTER TABLE comments
				ADD CONSTRAINT fk1_comments
					FOREIGN KEY (post_id) REFERENCES posts(id),
				ADD CONSTRAINT fk2_comments
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# Groups
		execute <<-SQL
			ALTER TABLE groups
				ADD CONSTRAINT fk_groups
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# GroupMembers
		execute <<-SQL
			ALTER TABLE group_members
				ADD CONSTRAINT fk1_group_members
					FOREIGN KEY (group_id) REFERENCES groups(id),
				ADD CONSTRAINT fk2_group_members
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL
		
		# GroupRequests
		execute <<-SQL
			ALTER TABLE group_requests
				ADD CONSTRAINT fk1_group_requests
					FOREIGN KEY (group_id) REFERENCES groups(id),
				ADD CONSTRAINT fk2_group_requests
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# Messages
		execute <<-SQL
			ALTER TABLE messages
				ADD CONSTRAINT fk_messages
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# MessageReceivers
		execute <<-SQL
			ALTER TABLE message_receivers
				ADD CONSTRAINT fk1_message_receivers
					FOREIGN KEY (message_id) REFERENCES messages(id),
				ADD CONSTRAINT fk2_message_receivers
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# Preferences
		execute <<-SQL
			ALTER TABLE preferences
				ADD CONSTRAINT fk_preferences
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL

		# Sales
		execute <<-SQL
			ALTER TABLE sales
				ADD CONSTRAINT fk1_sales
					FOREIGN KEY (advertisement_id) REFERENCES advertisements(id),
				ADD CONSTRAINT fk2_sales
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL
  end

  def down
		# Friends
		execute <<-SQL
			ALTER TABLE friends
				DROP FOREIGN KEY fk1_friends,
				DROP FOREIGN KEY fk2_friends
		SQL

		# FriendRequests
		execute <<-SQL
			ALTER TABLE friend_requests
				DROP FOREIGN KEY fk1_friend_requests,
				DROP FOREIGN KEY fk2_friend_requests
		SQL

		# Circles
		execute <<-SQL
			ALTER TABLE circles
				DROP FOREIGN KEY fk_circles
		SQL

		# CircleMembers
		execute <<-SQL
			ALTER TABLE circle_members
				DROP FOREIGN KEY fk1_circle_members,
				DROP FOREIGN KEY fk2_circle_members
		SQL

		# Posts
		execute <<-SQL
			ALTER TABLE posts
				DROP FOREIGN KEY fk1_posts,
				DROP FOREIGN KEY fk2_posts,
		SQL

		# Comments
		execute <<-SQL
			ALTER TABLE comments
				DROP FOREIGN KEY fk1_comments,
				DROP FOREIGN KEY fk2_comments
		SQL
		
		# Groups
		execute <<-SQL
			ALTER TABLE groups
				DROP FOREIGN KEY fk_groups
		SQL

		# GroupMembers
		execute <<-SQL
			ALTER TABLE group_members
				DROP FOREIGN KEY fk1_group_members,
				DROP FOREIGN KEY fk2_group_members
		SQL

	  # GroupRequests
		execute <<-SQL
			ALTER TABLE group_requests
				DROP FOREIGN KEY fk1_group_requests,
				DROP FOREIGN KEY fk2_group_requests
		SQL

		# Messages
		execute <<-SQL
			ALTER TABLE messages
				DROP FOREIGN KEY fk_messages
		SQL

		execute <<-SQL
			ALTER TABLE message_receivers
				DROP FOREIGN KEY fk1_message_receivers,
				DROP FOREIGN KEY fk2_message_receivers
		SQL

		execute <<-SQL
			ALTER TABLE preferences
				DROP FOREIGN KEY fk_preferences
		SQL

		execute <<-SQL
			ALTER TABLE sales
				DROP FOREIGN KEY fk1_sales,
				DROP FOREIGN KEY fk2_sales
		SQL
  end
end
