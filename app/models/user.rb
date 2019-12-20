# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }

  has_many :posts
  has_many :likes
  has_many :comments
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed && friendship.friend.id != self.id}
    friends_array
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map do |friendship|
      friendship.friend unless friendship.confirmed || friendship.sender_id == friendship.friend.id
    end .compact
  end

  # Users who have requested to be friends
  def friend_requests
    friendships.map do |friendship|
      friendship.friend unless friendship.confirmed || friendship.sender_id != friendship.friend.id
    end .compact
  end

  def friend?(user)
    friends.include?(user)
  end
end
