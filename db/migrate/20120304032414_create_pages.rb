class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :type
      t.integer :owner

      t.timestamps
    end
  end
end
