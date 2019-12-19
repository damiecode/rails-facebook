# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 255 }, presence: true
end
