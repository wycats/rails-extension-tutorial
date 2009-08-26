require File.join(File.dirname(__FILE__), '..', 'test_helper')

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

class MiddlewareTest < ActionController::IntegrationTest
  def setup
    User.delete_all
    User.create(:name => "dave", :password => "secret", :password_confirmation => "secret")
  end

  # Replace this with your real tests.
  test "login does return a 401" do
    visit "/admin/login"
    assert_response :success
  end
  
  test "other URLs return a 401" do
    visit "/admin"
    assert_response :unauthorized
    assert_have_selector "p:contains('Access denied')"
  end

  test "if the user is :logged_out, redirect to /admin/login" do
    basic_auth "dave", "secret"
    visit "/admin"
    visit "/admin/logout"

    visit "/admin"
    assert_match %r{/admin/login$}, current_url
  end
end
