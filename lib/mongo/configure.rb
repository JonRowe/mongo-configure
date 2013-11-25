require 'morphine'
require "mongo/configure/version"
require 'mongo/configure/uri'

module Mongo
  module Configure

    class Config
      include Morphine

      register(:connection) { Connection }

      def initialize(uri)
        @uri = uri
      end
      attr_reader :uri
      def load
        connection.from_uri(@uri.to_s).db @uri.database
      end
    end

    class << self

      def from_uri(uri)
        @config = Config.new URI.parse uri
      end
      def from_database(name)
        @config = Config.new URI.new.tap { |uri| uri.database = name }
      end
      def current
        @config ||= Config.new 'localhost/database'
      end

    end
  end
end
