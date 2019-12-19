# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.valid?
      @comment.save
    else
      flash[:alert] = 'You can not create an empty comment!'
    end
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
