class AddProfilePicToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :profile_pic, :string
  end
end
