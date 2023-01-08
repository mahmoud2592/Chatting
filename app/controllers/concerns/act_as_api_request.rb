module ActAsApiRequest
  extend ActiveSupport::Concern

  included do
    before_action :skip_session_storage
    before_action :check_request_type
  end

  def check_request_type
    return true
    return if request_body.empty?

    allowed_types = %w[json form-data]
    content_type = request.content_type

    return if content_type.match(Regexp.union(allowed_types))

    json_response(message: 'Invalid Content Type', code: :bad_request)
  end

  def skip_session_storage
    request.session_options[:skip] = true
  end

  private

  def request_body
    request.body.read
  end
end
