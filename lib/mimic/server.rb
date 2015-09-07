require 'singleton'

module Mimic
  class Server
    include Singleton

    def logger
      @logger ||= Logger.new(StringIO.new)
    end

    def serve(app, options)
      if options[:fork]
        @thread = Thread.fork do
          start_service(app, options)
        end

        wait_for_service(app.hostname, options[:port])

      else
        start_service(app, options)
      end
    end

    def start_service(app, options)
      Rack::Handler::Thin.run(app.url_map, {
        :Host       => options[:Host] || 'localhost',
        :Port       => options[:port],
        :Logger     => logger,
        :AccessLog  => logger
      })
    end

    def shutdown
      Thread.kill(@thread) if @thread
    end

    # courtesy of http://is.gd/eoYho

    def listening?(host, port)
      begin
        socket = TCPSocket.new(host, port)
        socket.close unless socket.nil?
        true
      rescue Errno::ECONNREFUSED, SocketError,
        Errno::EBADF,           # Windows
        Errno::EADDRNOTAVAIL    # Windows
        false
      end
    end

    def wait_for_service(host, port, timeout = 5)
      start_time = Time.now

      until listening?(host, port)
        if timeout && (Time.now > (start_time + timeout))
          raise SocketError.new("Socket did not open within #{timeout} seconds")
        end
      end
    end
  end
end
