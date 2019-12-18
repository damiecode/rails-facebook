# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CommentsController' do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
    @post = @user.posts.build(content: 'This is a post');
  end

  describe "Create a comment" do
    it 'creates a valid comment' do
      @comment = @post.comments.create(content: 'this is a comment', user_id: @user.id)
      expect(@comment).to be_valid
    end

    it 'creates a blank comment' do
      @comment = @post.comments.create(content: ' ', user_id: @user.id)
      expect(@comment.valid?).to eql(false)
    end
  end
end