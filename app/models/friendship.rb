# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :avoid_self_friendship
  validate :duplicate
  
  def avoid_self_friendship
    if user_id == friend_id
      errors.add(:friend_id, "Can't friend yourself")
    end
  end

  def duplicate
    if !Friendship.where(user_id: user, friend_id: friend, confirmed: true).empty? or !Friendship.where(user_id: friend, friend_id: user, confirmed: true).empty?
      errors.add(:base, "Friendship exist")
    end
  end
end
