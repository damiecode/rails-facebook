# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  def new
    @post = Post.new
  end

  def show; end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
