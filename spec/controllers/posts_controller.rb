require 'rails_helper'

Rspec.describe "PostsController" do
  describe "Create new post" do
    it 'creates a valid post' do
      @post = Post.new(content: 'A new post')
      expect(@post).to be_valid  
    end
  end

  it 'creates a blank post' do
    @post =  Post.new(content: "")
    expect(@Post).to_not be_valid  
  end
end