class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # HTTP Basic authentication
  http_basic_authenticate_with name: 'tweetbox', password: 'dash'
end
