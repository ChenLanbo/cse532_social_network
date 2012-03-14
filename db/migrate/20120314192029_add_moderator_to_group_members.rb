class AddModeratorToGroupMembers < ActiveRecord::Migration
  def change
		add_column :group_members, :moderator, :boolean
  end
end
