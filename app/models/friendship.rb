# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validate :avoid_self_friendship
  validate :duplicate

  def avoid_self_friendship
    errors.add(:friend_id, "Can't friend yourself") if user_id == friend_id
  end

  def duplicate
    unless !Friendship.where(user_id: user, friend_id: friend, confirmed: true).empty? ||
           !Friendship.where(user_id: friend, friend_id: user, confirmed: true).empty?
    end
  end
end
