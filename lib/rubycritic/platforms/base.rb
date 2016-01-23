require 'rubycritic/configuration'

module Rubycritic
  module Platforms
    class Base
      attr_reader :browser_name

      def initialize
        @browser_name = Config.open_with || ''
      end

      def can_open?
        fail NotImplementedError
      end

      def browser
        fail NotImplementedError
      end

      def open(_)
        fail NotImplementedError
      end

      def application
        fail NotImplementedError
      end

      def platform
        @platform ||= begin
          require 'rbconfig'
          host_os = ::RbConfig::CONFIG['host_os']
          case host_os
          when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
            :windows
          when /darwin|mac os/
            :darwin
          when /linux/
            :linux
          when /solaris|bsd/
            :unix
          end
        end
      end
    end
  end
end
