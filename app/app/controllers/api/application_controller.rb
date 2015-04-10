module Api
  class ApplicationController < ActionController::Base

    # APIなのでCSRFの対策は不要
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    rescue_from ActiveRecord::RecordInvalid, with: -> (e) { render_bad_request(Bang::Error::ValidationError.convert(e)) }
    rescue_from Bang::Error::AuthenticationFailed, with: -> (e) { render_unauthorized(e) }
  end
end
