# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :other_user, class_name: 'User'
end
