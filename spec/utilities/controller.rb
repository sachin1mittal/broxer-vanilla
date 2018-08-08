module ControllerUtility
  #
  # Parse and return response body as json
  #
  # @return [JSON]
  def response_body
    JSON.parse(response.body)
  end
end
