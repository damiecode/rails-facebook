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

  def update
    @friendship = Friendship.find(params[:id].to_i).update_column(:confirmed, true)
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id].to_i)
    @friendship.destroy
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def accept_params
    params.require(:accept_params).permit(:friend)
  end
end
