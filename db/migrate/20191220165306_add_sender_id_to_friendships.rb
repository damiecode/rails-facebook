class AddSenderIdToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :sender_id, :integer
  end
end
