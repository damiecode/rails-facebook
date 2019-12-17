# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostsController' do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
  end
  describe 'Create new post' do
    it 'creates a valid post' do
      @post = @user.posts.build(content: 'A new post')
      expect(@post).to be_valid
    end
  end

  it 'creates a blank post' do
    @post = @user.posts.build(content: ' ')
    expect(@post.valid?).to eql(false)
  end
end
