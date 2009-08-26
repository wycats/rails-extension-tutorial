module Middlewares
  class Authorize < ActionController::Middleware
    include ActionController::UrlFor
    include ActionController::Redirector
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::Session

    def call(env)
      # Continue if this is the admin login route
      if env["PATH_INFO"] == "/admin/login"
        return app.call(env)
      end

      unless User.find_by_id(session[:user_id])
        if session[:user_id] == :logged_out
          redirect_to url_for(:controller => :admin, :action => :login), 302
          return to_a
        end

        authenticate_or_request_with_http_basic('Depot') do |username, password|
          user = User.authenticate(username, password)
          session[:user_id] = user.id if user
        end

        return to_a
      end

      return app.call(env)
    end
  end
end