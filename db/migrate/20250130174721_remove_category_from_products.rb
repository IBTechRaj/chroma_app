class RemoveCategoryFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :category_id, :bigint
  end
end
