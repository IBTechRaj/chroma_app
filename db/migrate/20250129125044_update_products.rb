class UpdateProducts < ActiveRecord::Migration[8.0]
  def change
    rename_column :products, :name, :product_name  # Rename 'name' to 'product_name'
    add_column :products, :brand_name, :string
    add_column :products, :category, :string
    add_column :products, :description, :text
    add_column :products, :selling_price, :decimal, precision: 10, scale: 2
    add_column :products, :product_image, :json  # Using JSON for multiple images
  end
end
