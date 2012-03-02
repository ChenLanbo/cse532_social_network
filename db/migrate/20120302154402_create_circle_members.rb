class CreateCircleMembers < ActiveRecord::Migration
  def change
    create_table :circle_members do |t|
      t.integer :circle_id
      t.integer :user_id

      t.timestamps
    end
  end
end
