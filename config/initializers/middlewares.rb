require "middlewares/authorize"
ActionController::Dispatcher.middleware.use Middlewares::Authorize