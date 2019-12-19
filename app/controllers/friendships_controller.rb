class FriendshipsController < ApplicationController
  before_action :require_login

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id

    if @friendship.valid?
      @friendship.save
    else
      flash[:alert] = 'Invalid friend request'
    end
    redirect_to request.referrer
  end

  def index
    @friends_pending_requests = current_user.friend_requests
    @user_pending_requests = current_user.pending_friends
    @friends = current_user.friends
  end

  def update
    current_user.confirm_friend(accept_params)
  end

  def destroy
    @friendship.destroy
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def accept_params
    params.require(:accept_params).permit(:friend)
  end
end
