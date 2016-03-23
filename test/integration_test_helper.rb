require "test_helper"
require "capybara/rails"
require "capybara/poltergeist"

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,
      js_errors: false,
      debug: false,
      window_size: [1920, 6000]
    )
  end

  Capybara.javascript_driver = :poltergeist
end

def sign_in(email='scott.miller@test.com')
  visit "/en/users/sign_in"
  sleep(1)
  within first('div.login-form') do
    fill_in("user[email]", with: email)
    fill_in("user[password]", with: '12345678')
    click_on('Sign in')
  end
end

def sign_in_by_modal(email='scott.miller@test.com')
  visit('/')
  within("div#above-header") do
    click_on "Sign in", wait: 30
  end
  within('div#login-modal') do
    fill_in("user[email]", with: email)
    fill_in("user[password]", with: '12345678')
    click_on('Sign in')
  end
end

def sign_out
  logout(:user)
  sleep(3)
end

def click_logout
  sleep(2)
  find('a.navbar-brand').click
  sleep(2)
  within("div#above-header") do
    find('.logout-link').trigger('click')
  end
  sleep(3)
end