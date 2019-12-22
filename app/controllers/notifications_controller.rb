# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    current_user.notifications.delete_all
    redirect_back(fallback_location: root_url)
  end
end
