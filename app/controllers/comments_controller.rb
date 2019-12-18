# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)

    if @comment.valid?
      @comment.save
    else
      flash[:alert] = 'You can not create an empty comment!'
    end
    redirect_to "/posts/#{@comment.post_id}"
  end

  private

  def comment_params
    params.require(:post).permit(:content, :user_id, :post_id)
  end
end
