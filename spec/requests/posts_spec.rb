# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  user1 = User.create!(name: 'example', email: 'test2@example.com', password: '123456', password_confirmation: '123456')
  post1 = user1.posts.create!(content: 'A new post')

  let(:user_params) do
    {
      user: {
        email: 'test2@example.com',
        password: '123456'
      }
    }
  end

  let(:attributes) do
    {
      post: {
        content: post1.content
      }
    }
  end

  let(:empty_attributes) do
    {
      post: {
        content: ''
      }
    }
  end

  describe 'GET /posts and /posts/new' do
    context 'when logged in' do
      before do
        post '/users/sign_in', params: user_params
      end

      it 'returns success for /posts' do
        get '/posts'

        expect(response).to have_http_status(200)
      end

      it 'returns success for /posts/new' do
        get '/posts/new'

        expect(response).to have_http_status(200)
      end
    end

    context 'when not logged in' do
      it 'redirects to login path when trying to get /posts' do
        get '/posts'

        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirects to login path when trying to get /posts/new' do
        get '/posts'

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'POST /posts' do
    context 'when logged in and parameters are valid' do
      before do
        post '/users/sign_in', params: user_params
      end

      it 'redirects to /posts' do
        post '/posts', params: attributes

        expect(response).to redirect_to('/posts')
      end
    end

    context 'when logged in and parameters are invalid' do
      before do
        post '/users/sign_in', params: user_params
      end

      it 'Does not create post' do
        post '/posts', params: attributes

        post_object = Post.find_by(content: empty_attributes[:post][:content])

        expect(post_object).to be_nil
      end
    end

    context 'when not logged in' do
      it 'redirects to sign in path' do
        post '/posts', params: attributes

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
