module Mimic
  class Stub
    def initialize(data, method = nil)
      @data = data
      @method = method
    end

    def on(host)
      get_stub(host).tap do |stub|
        stub.returning(body, code, headers)
        stub.with_query_parameters(params)
        stub.echo_request!(echo_format)
      end
    end

    def get_stub(host)
      host.send(@method.downcase.to_sym, path)
    end

    def echo_format
      @data['echo'].to_sym rescue nil
    end

    def path
      @data['path'] || '/'
    end

    def body
      @data['body'] || ''
    end

    def code
      @data['code'] || 200
    end

    def headers
      @data['headers'] || {}
    end

    def params
      @data['params'] || {}
    end
  end
end
