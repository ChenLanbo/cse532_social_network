class RemoveTypeFromAdvertisements < ActiveRecord::Migration
  def up
    remove_column :advertisements, :type
  end

  def down
    add_column :advertisements, :type, :string
  end
end
