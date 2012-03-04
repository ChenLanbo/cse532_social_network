class RemoveTypeFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :type
  end

  def down
    add_column :pages, :type, :string
  end
end
