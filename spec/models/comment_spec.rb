# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'content' do
    before :each do
      @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
      @post = @user.posts.build(content: 'This is a post');
      @comment = @post.comments.create(content: 'this is a comment', user_id: @user.id)
      expect(@cpmment.valid?).to  eql(true)
    end

    it 'should not be empty' do
      @comment.content = ' '
      expect(@comment.valid?).to eql(false)
      expect(@comment.errors.messages[:content]).to include("can't be blank")
    end

    it 'should belong to user' do
      @comment.user = nil
      expect(@comment.valid?).to eql(false)
      expect(@comment.errors.messages[:user]).to include('must exist')
    end

    it 'should belong to a post' do
      @comment.post = nil
      expect(@comment.valid?).to eql(false)  
    end
  end
end
