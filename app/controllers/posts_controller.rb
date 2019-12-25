# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, except: %i[new create index]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :require_login

  def index
    @post = Post.new
    @users = User.all
    @comment = Comment.create
    @friends = current_user.friends
    @posts = current_user.feed
  end

  def new
    @post = current_user.posts.build
  end

  def show; end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def def(_update)
    if @post.update(params[:post][:content])
      flash[:success] = 'Post was successfully updated'
      redirect_to @post
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
