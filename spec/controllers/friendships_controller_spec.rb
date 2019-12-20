# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  before :each do
    @user1 = User.create(name: 'Joe', email: 'joe@gmail.com', password: '123456')
    @user2 = User.create(name: 'Mike', email: 'mike@gmail.com', password: '123456')
    @friendship = @user1.friendships.create(friend_id: @user2.id)
  end

  # describe "create" do
  #   context "as an authenticated user you can" do
  #     it "send request to another user" do
  #       sign_in user
  #       expect do
  #         post :create, params: { friendship}
  #       end
  #     end

  #   end

  # end
end
