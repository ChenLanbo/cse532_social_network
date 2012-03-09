class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :advertisement_id
      t.integer :user_id
      t.integer :quantity

      t.timestamps
    end
  end
end
