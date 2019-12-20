# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :require_login

  def create
    @friendship1 = Friendship.new(friendship_params)
    @friendship1.user_id = current_user.id
    @friendship2 = Friendship.new(user_id: @friendship1.friend_id, friend_id: @friendship1.user_id)

    if @friendship1.valid? && @friendship2.valid?
      @friendship1.save
      @friendship2.save
    else
      flash[:alert] = 'Invalid friend request'
    end
    redirect_to request.referrer
  end

  def update
    @friendship1 = Friendship.find(params[:id].to_i).update_column(:confirmed, true)
    @friendship2 = Friendship.where('user_id = ? and friend_id = ?', @friendship1.friend_id, @friendship1.user_id)
    @friendship2.update_column(:confirmed, true)
    redirect_to users_path
  end

  def destroy
    @friendship1 = Friendship.find_by(id: params[:id].to_i)
    @friendship2 = Friendship.where('user_id = ? and friend_id = ?', @friendship1.friend_id, @friendship1.user_id)
    @friendship1.destroy
    @friendship2.destroy
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
