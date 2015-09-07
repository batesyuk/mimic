require 'mimic/fake_host'
require 'singleton'
require 'rack'
require 'logger'

module Mimic
  MIMIC_DEFAULT_PORT = 11988

  MIMIC_DEFAULT_OPTIONS = {
    :hostname => 'localhost',
    :port => MIMIC_DEFAULT_PORT,
    :remote_configuration_path => nil,
    :fork => true,
    :log => nil
  }

  def self.mimic(options = {}, &block)
    options = MIMIC_DEFAULT_OPTIONS.merge(options)
    host = FakeHost.new(options)
    host.instance_eval(&block) if block_given?

    Server.instance.serve(host, options)

    add_host(host)
  end

  def self.cleanup!
    Mimic::Server.instance.shutdown
  end

  def self.reset_all!
    @hosts.each { |h| h.clear }
  end

  private

  def self.add_host(host)
    host.tap { |h| (@hosts ||= []) << h }
  end
end
