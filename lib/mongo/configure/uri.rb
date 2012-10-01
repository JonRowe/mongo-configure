module Mongo
  module Configure
    class URI < Struct.new(:scheme,:host,:port,:database,:user,:password)
      def initialize(scheme='mongodb',host='localhost',port='27017',database='',user=nil,password=nil)
        super
      end

      def self.parse(string)
        uri = ::URI.parse string
        new uri.scheme, uri.host, uri.port.to_s, uri.path.gsub(/^\//,''), uri.user, uri.password
      end
      def auth
        if user || password
          [user,password].join(':')+'@'
        else
          ''
        end
      end
      def to_s
        "#{scheme}://#{auth}#{host}:#{port}/#{database}"
      end
    end
  end
end
