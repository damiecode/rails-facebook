class AddReferencesToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :likes, index:true
    add_reference :posts, :comments, index:true
  end
end
