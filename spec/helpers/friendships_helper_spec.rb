# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FriendshipsHelper', type: :helper do
  before :each do
    @user1 = User.create(name: 'Joe', email: 'joe@gmail.com', password: '123456')
    @user2 = User.create(name: 'Mike', email: 'mike@gmail.com', password: '123456')
    @friendship = @user1.friendships.create(friend_id: @user2.id)
  end

  describe 'Find friends' do
    it 'finds friendship' do
      expect(@user1.id).to eql(user_id.first)
      expect(@user2.id).to eql(friend_id.first)
    end
  end
end
