# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
class FriendshipsController < ApplicationController
  before_action :require_login

  def create
    @friendship1 = Friendship.new(friendship_params)
    @friendship1.user_id = current_user.id
    @friendship1.sender_id = current_user.id
    @friendship2 = Friendship.new(sender_id: @friendship1.sender_id, user_id: @friendship1.friend_id, friend_id: @friendship1.user_id)

    if @friendship1.valid? && @friendship2.valid?
      @friendship1.save
      @friendship2.save
    else
      flash[:alert] = 'Invalid friend request'
    end
    redirect_to request.referrer
  end

  def update
    friendships = Friendship.where(id: params[:id])
    friendships.update(confirmed: true)
  end

  def destroy

    Friendship.where(id: params[:id]).destroy_all
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
end
# rubocop:enable Metrics/LineLength
