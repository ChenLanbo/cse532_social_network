class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :type
      t.string :company
      t.string :item_name
      t.decimal :unit_price
      t.integer :quantity

      t.timestamps
    end
  end
end
