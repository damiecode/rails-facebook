# frozen_string_literal: true

module ApplicationHelper
  def notice_count
		if current_user.notifications.count == 0
			number_of_notices = nil
		else
			number_of_notices = "#{current_user.notifications.count}"
		end
	end

	def construct_notices
		notices = []
		current_user.notifications.each do |notice|
			notices << notice_message()
		end
		notices
	end
end

def notice_message()
	message = "New Friend Requests!" 
	message
end
