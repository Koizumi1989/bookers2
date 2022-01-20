class RemoveProfileImageFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :profile_image, :integer
  end
end
