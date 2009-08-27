module Middlewares
  class Authorize
    def initialize(app)
      @app = app
    end

    def call(env)
      # Continue if this is the admin login route
      return @app.call(env) if env["PATH_INFO"] == "/admin/login"

      # The session object and request object are memoized
      # in the env
      session = env["rack.session"]
      request = ActionDispatch::Request.new(env)

      unless User.find_by_id(session[:user_id])
        if session[:user_id] == :logged_out
          return [302, {"Location" => "/admin/login"}, "You are being redirected."]
        end
        
        # Access the HttpAuthentication::Basic helpers directly
        valid = ActionController::HttpAuthentication::Basic.authenticate(request) do |username, password|
          user = User.authenticate(username, password)
          session[:user_id] = user.id if user
        end

        unless valid
          headers = {"WWW-Authenticate" => %{Basic realm="Application"}}
          body    = "HTTP Basic: Access denied.\n"
          # return Rack response
          return [401, headers, body]
        end
      end
      @app.call(env)
    end
  end
end