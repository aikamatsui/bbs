class AddCategoryIdToContribution < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :category_id, :integer
  end
end
