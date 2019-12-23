# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
    @post = @user.posts.build(content: 'This is a post')
    @post.save
  end

  it 'should return false without a post id' do
    @like = @user.likes.build
    @like.valid?
    expect(@like.errors[:post]).to include('must exist')
  end

  it 'should return true with a post id' do
    @like = @user.likes.build(post_id: @post.id)
    expect(@like.valid?).to eql(true)
  end

  it 'should return false without a user id' do
    @like = @post.likes.build
    @like.valid?
    expect(@like.errors[:user]).to include('must exist')
  end

  it 'should return true with a user id' do
    @like = @post.likes.build(user_id: @user.id)
    expect(@like.valid?).to eql(true)
  end

  it 'should ensure a user cannot like a post twice' do
    @like = @post.likes.create(user_id: @user.id)
    @like2 = @post.likes.create(user_id: @user.id)
    expect(@like2.valid?).to eql(false)
    expect(@like2.errors[:user_id]).to include('has already been taken')
  end
end
