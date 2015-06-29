class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ErrorRenderer

  rescue_from WeakParameters::ValidationError, with: -> (e) { render_bad_request(Bang::Error::ValidationError.convert(e)) }
end
