require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FriendshipsHelper. For example:
#
# describe FriendshipsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe 'FriendshipsHelper', type: :helper do
 before :each do
    @user1  = User.create(name: 'Joe', email: 'joe@gmail.com', password: '123456')
    @user2  = User.create(name: 'Mike', email: 'mike@gmail.com', password: '123456')
    @friendship = @user1.friendships.create(friend_id: @user2.id)
  end

  describe "Find friends" do
    it "finds friendship" do
      expect(@user1.id).to eql(@user_id)
      expect(@user2.id).to eql(@friend_id)
    end
  end
end
