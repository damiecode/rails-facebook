# frozen_string_literal: true

module PostsHelper
  def liked?(id)
    !current_user.likes.map(&:post_id).include? id
  end
end