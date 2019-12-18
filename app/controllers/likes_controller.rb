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
    redirect_to "/posts/#{@like.post_id}"
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
