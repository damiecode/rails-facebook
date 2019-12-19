# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def require_login
    redirect_to '/users/sign_in' unless user_signed_in?
  end
end
