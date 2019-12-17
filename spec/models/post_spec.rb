require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
  end
  describe 'content' do
    it 'should not be empty' do
      @post = @user.posts.build(content: '')
      expect(@post.valid?).to eql(false)
      expect(@post.errors.messages[:content]).to include("can't be blank")
    end
    it 'should not be longer than 255' do
      @post = @user.posts.build(content: 'A' * 256)
      expect(@post.valid?).to eql(false)
      expect(@post.errors.messages[:content]).to include('is too long (maximum is 255 characters)')
    end
    it 'should have an author' do
      @post = Post.new(content: 'A' * 10)
      expect(@post.valid?).to eql(false)
      expect(@post.errors.messages[:user]).to include('must exist')
    end
  end
end