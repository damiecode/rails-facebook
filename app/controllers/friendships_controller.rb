# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :require_login

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id

    if @friendship.valid?
      @friendship.save
        flash[:success] = "Friend request sent"
        send_notice
    else
      flash[:alert] = 'Invalid friend request'
    end
    redirect_to request.referrer
  end

  def update
    @friendship = Friendship.find(params[:id].to_i).update_column(:confirmed, true)
    flash[:success] = "Request Accepted!"
    redirect_to request.referrer
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id].to_i)
    @friendship.destroy
    flash[:success] = "Friend removed"
    redirect_to users_path
  end

  def index
    @pending_friend_requests = current_user.friend_requests
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def accept_params
    params.require(:accept_params).permit(:friend)
  end

  def send_notice
     notice = @friendship.friend.notifications.build(other_user_id: current_user.id,
                     type_id: @friendship.id)
    notice.save
  end
end
