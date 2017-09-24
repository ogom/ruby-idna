require 'idna/version'
require 'idna/default'
require 'idna/configure'
require 'idna/error'
require 'idna/client'

# Internationalizing Domain Names in Applications
module Idna
  class << self
    def configure
      yield Idna::Configure
    end

    def config
      Idna::Configure
    end

    def client
      Idna::Client.lib_load! unless @client
      @client ||= Idna::Client.new
    end

    def reload!
      @client = nil
      Idna::Client.lib_load!
      true
    end

    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end
  end
end

Idna::Configure.setup
