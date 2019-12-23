# frozen_string_literal: true

module ApplicationHelper
  def notice_count
    if current_user.notifications.count.zero?
      nil
    else
      current_user.notifications.count.to_s
    end
  end

  def construct_notices
    notices = []
    current_user.notifications.each do |_notice|
      notices << notice_message
    end
    notices
  end
end

def notice_message
  message = 'New Friend Requests!'
  message
end
