# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, :require_login

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all - [current_user]
    @friends = current_user.friends
    @requests = current_user.friend_requests
  end
end
