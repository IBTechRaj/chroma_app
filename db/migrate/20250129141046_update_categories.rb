class UpdateCategories < ActiveRecord::Migration[8.0]
  def change
      rename_column :categories, :name, :category_name
  end
end
