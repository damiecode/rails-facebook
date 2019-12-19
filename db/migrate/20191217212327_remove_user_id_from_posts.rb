class RemoveUserIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :posts, :user, null: false, foreign_key: true
  end
end
