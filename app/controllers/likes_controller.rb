# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :require_login

  def create
    @like = Like.new(like_params)

    if @like.valid?
      @like.save
    else
      flash[:alert] = 'You have already liked this post!'
    end
    if request.referrer
      redirect_to request.referrer
    else
      redirect_to root_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
