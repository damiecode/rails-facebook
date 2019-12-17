# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_registration_path
    assert_response :success
  end

  test 'should create a new user' do
    post registration_path, params: { name: 'Mike',
                                      email: 'mike@example.com',
                                      password: '123456',
                                      password_confirmation: '123456' }
    asset_redirected_to user_url(User.last)
  end
end
