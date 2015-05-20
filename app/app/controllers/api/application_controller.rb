module Api
  class ApplicationController < ActionController::Base
    include ErrorRenderer

    # APIなのでCSRFの対策は不要
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    before_action :authenticate

    rescue_from ActiveRecord::RecordInvalid, with: -> (e) { render_bad_request(Bang::Error::ValidationError.convert(e)) }
    rescue_from WeakParameters::ValidationError, with: -> (e) { render_bad_request(Bang::Error::ValidationError.convert(e)) }
    rescue_from Bang::Error::AuthenticationFailed, with: -> (e) { render_unauthorized(e) }
    rescue_from Bang::Error::UserBanned, with: -> (e) { render_unauthorized(e) }
    rescue_from Bang::Error::InvalidUserBang, with: -> (e) { render_bad_request(e) }

    def authenticate
      raise Bang::Error::AuthenticationFailed unless current_user.present?
      raise Bang::Error::UserBanned if current_user.banned?
    end

    def custom_header
      @custom_header ||= Bang::HTTPHeader.new(request.headers)
    end

    def current_user
      @current_user ||= User.fetch_by_token(custom_header.token) if custom_header.present?
    end
  end
end
