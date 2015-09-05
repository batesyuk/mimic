require 'helpers/request_echo'

module Helpers
  def echo_request!(format)
    RequestEcho.new(request).response_as(format)
  end
end
