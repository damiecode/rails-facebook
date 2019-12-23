# frozen_string_literal: true

module FriendshipsHelper
  def find_friendship(user, friend)
    f1 = Friendship.where('user_id = ? and friend_id = ?', user.id, friend.id)
    f2 = Friendship.where('user_id = ? and friend_id = ?', friend.id, user.id)
    [f1[0][:id], f2[0][:id]]
  end
end
