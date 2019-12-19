# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Friendship", type: :model do
  before :each do
    @user1  = User.create(name: 'Joe', email: 'joe@gmail.com', password: '123456')
    @user2  = User.create(name: 'Mike', email: 'mike@gmail.com', password: '123456')
    @friendship = @user1.friendships.create(friend_id: @user2.id)
  end

  describe 'create friendship' do
    it 'is valid with a friend and a user' do
      expect(@friendship.valid?).to eql(true)
    end

    context 'confirm friend' do
      it 'creates friendship for both side' do
        friendship = @user1.friendships.build(friend_id: @user2.id)
        expect do
          friendship.save
          friendship.confirm_friend
          expect(@user1.friends).to_not be_empty
          expect(@user2.friends).to_not be_empty
          expect(friendship.confirmed).to be_truthy
        end
      end
    end

      context 'destroys friend' do
        it 'destroys friendship for both side' do
          friendship = @user1.friendships.build(friend_id: @user2.id)
          expect do
            friendship.save
            friendship.confirm_friend
            friendship.destroy
            expect(@user1.friends).to be_empty
            expect(@user2.friends).to be_empty
            expect(friendship.confirmed).to be_falsy
          end            
        end
      end
    end
  end
