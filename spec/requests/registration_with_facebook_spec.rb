# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'RegisterationWithFacebooks', type: :feature do
  it 'can sign in user with facebook account' do
    visit root_path
    expect(page).to have_content('Sign in with Facebook')
  end

  # it 'has facebook image as profile image' do
  #   visit root_path
  #   click_on 'Sign in with Facebook'
  #   expect(page).to have_css("img[src='http://link.to']")
  # end
end
