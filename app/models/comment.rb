# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :content, presence: true
end
