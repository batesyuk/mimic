require 'json'
require 'plist'
require 'mimic/api_request'

module Mimic
  class API < Sinatra::Base
    class << self
      attr_accessor :host
    end

    def host
      self.class.host
    end

    post "/get" do
      process_request request, 'get'
    end

    post "/post" do
      process_request request, 'post'
    end

    post "/put" do
      process_request request, 'put'
    end

    post "/delete" do
      process_request request, 'delete'
    end

    post "/head" do
      process_request request, 'head'
    end

    post "/multi" do
      api_request = APIRequest.from_request(request)
      api_request.setup_stubs_on(host)
      [201, {"Content-Type" => api_request.request_content_type}, api_request.response]
    end

    post "/clear" do
      response_body = self.host.inspect
      self.host.clear
      [200, {}, "Cleared stubs: #{response_body}"]
    end

    get "/ping" do
      [200, {}, "OK"]
    end

    get "/debug" do
      [200, {}, self.host.inspect]
    end

    get "/requests" do
      [200, {"Content-Type" => "application/json"}, {"requests" => host.received_requests.map(&:to_hash)}.to_json]
    end

    def process_request request, verb
      api_request = APIRequest.from_request(request, verb)
      api_request.setup_stubs_on(host)
      [201, {"Content-Type" => api_request.request_content_type}, api_request.response]
    end
  end
end
