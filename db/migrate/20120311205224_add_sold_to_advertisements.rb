class AddSoldToAdvertisements < ActiveRecord::Migration
  def change
		add_column :advertisements, :sold, :integer
  end
end
