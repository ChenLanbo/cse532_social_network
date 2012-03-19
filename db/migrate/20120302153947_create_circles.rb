class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end

		execute <<-SQL
			ALTER TABLE circles
				ADD CONSTRAINT fk_circles
					FOREIGN KEY (user_id) REFERENCES users(id)
		SQL
  end
end
