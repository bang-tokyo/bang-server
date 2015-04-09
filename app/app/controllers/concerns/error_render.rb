module ErrorRenderer
  extend ActiveSupport::Concern

  def render_bad_request(exception = Univ::Error::Base.new)
    render_error 400, 'Bad Request', exception
  end

  def render_unauthorized(exception = Univ::Error::Base.new)
    render_error 401, 'Unauthorized', exception
  end

  def render_forbidden(exception = Univ::Error::Base.new)
    render_error 403, 'Forbidden', exception
  end

  def render_not_found(exception = Univ::Error::Base.new)
    render_error 404, 'Not Found', exception
  end


  private

  def render_error(status, title, exception)
    e = Univ::Error::Base.convert(exception)

    unless exception.is_a? Univ::Error::Base
      logger.error(exception.backtrace.join("\n"))
    end

    block = -> { render 'errors/default', layout: false, status: status, locals: {status: status, title: title, exception: e} }
    respond_to do |format|
      format.html &block
      format.json &block
    end
  end
end
