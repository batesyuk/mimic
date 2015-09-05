require 'sinatra/base'
require 'mimic/api'
require 'mimic/server'
require 'mimic/stubbed_request'
require 'helpers/helpers'

module Mimic
  class FakeHost
    attr_reader :hostname, :url_map
    attr_accessor :log

    def initialize(options = {})
      @hostname = options[:hostname]
      @remote_configuration_path = options[:remote_configuration_path]
      @log = options[:log]
      @imports = []
      setup_sinatra
      build_url_map!
    end

    def received_requests
      File.open("./log.txt", 'a') { |file| file.write("#{Time.now}: FAKE_HOST_RECEIVED_REQUESTS: #{@stubs}\n") }
      @stubs.select { |s| s.received }
    end

    def get(path, &block)
      request("GET", path, &block)
    end

    def post(path, &block)
      request("POST", path, &block)
    end

    def put(path, &block)
      request("PUT", path, &block)
    end

    def delete(path, &block)
      request("DELETE", path, &block)
    end

    def head(path, &block)
      request("HEAD", path, &block)
    end

    def import(path)
      if File.exists?(path)
        @imports << path unless @imports.include?(path)
        instance_eval(File.read(path))
      else
        raise "Could not locate file for stub import: #{path}"
      end
    end

    def call(env)
      @stubs.each(&:build)
      @app.call(env)
    end

    def setup_sinatra
      @stubs = []
      @app = Sinatra.new
      @app.use Rack::CommonLogger, self.log if self.log
      @app.not_found do
        [404, {}, ""]
      end
      @app.helpers do
        include Helpers
      end
      @imports.each { |file| import(file) }
    end

    def clear
      setup_sinatra
    end

    def inspect
      @stubs.inspect
    end

    private
    def method_missing(method, *args, &block)
      @app.send(method, *args, &block)
    end

    def request(method, path, &block)
      File.open("./log.txt", 'a') { |file| file.write("#{Time.now}: FAKE_HOST_REQUEST: #{method} #{path} #{block_given?}\n") }

      if block_given?
        @app.send(method.downcase, path, &block)
      else
        @stubs << StubbedRequest.new(@app, method, path)
        @stubs.last
      end
    end

    def build_url_map!
      routes = {'/' => self}

      if @remote_configuration_path
        API.host = self
        routes[@remote_configuration_path] = API
      end

      @url_map = Rack::URLMap.new(routes)
    end
  end
end
