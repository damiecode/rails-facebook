# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:attributes) do
    {
      user: {
        name: 'Mike',
        email: 'mike@example.com',
        password: '123456',
        password_confirmation: '123456'
      }
    }
  end

  let(:empty_attributes) do
    {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  end

  describe 'GET Sign Up Path' do
    it 'Return success' do
      get '/users/sign_up'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST Sign Up Path' do
    context 'Attributes are valid' do
      it 'Creates new user' do
        post '/users', params: attributes

        user = User.find_by(email: attributes[:user][:email])

        expect(user).not_to be_nil
      end

      it 'redirects to root' do
        post '/users', params: attributes

        expect(response).to redirect_to('/')
      end
    end

    context 'When any attribute is missing' do
      it 'Display error messages' do
        post '/users', params: empty_attributes

        expect(response.body).to include CGI.escapeHTML("Name can't be blank")
        expect(response.body).to include CGI.escapeHTML("Email can't be blank")
        expect(response.body).to include CGI.escapeHTML("Password can't be blank")
      end

      it 'Does not create user' do
        post '/users', params: empty_attributes

        user = User.find_by(email: attributes[:user][:email])

        expect(user).to be_nil
      end
    end
  end
end
