module ApiHelper
  def format_json_response(json, metadata = {})
    metadata = if metadata.nil? || metadata.empty?
                 default_response_metadata
               else
                 default_response_metadata.merge(metadata)
               end

    json.status metadata[:status]
    json.message metadata[:message]
    json.data do
      yield if block_given?
    end
  end

  private

  def default_response_metadata
    { status: 'success', message: '' }
  end
end
