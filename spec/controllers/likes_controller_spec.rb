# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
    @post = @user.posts.build(content: 'This is a post')
  end

  describe 'create likes' do
    it 'create a valid like' do
      @like = @user.likes.build(post_id: @post.id)
      expect(@like.valid?).to eql(true)
    end

    it 'creates an invalid like without post id' do
      @like = @user.likes.build
      expect(@like.valid?).to eql(false)
    end

    it 'creates an invalid like without user id' do
      @like = @post.likes.build
      expect(@like.valid?).to eql(false)
    end
  end
end
