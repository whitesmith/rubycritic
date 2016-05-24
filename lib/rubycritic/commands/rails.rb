require 'rubycritic/reporter'
require 'rubycritic/commands/default'

module Rubycritic
  module Command
    class Rails < Default
      def initialize(options)
        validate_rails_directory
        super
      end

      def validate_rails_directory
        raise ArgumentError, 'The -r option should be executed inside a rails app root folder' unless is_a_rails_app?
      end

      def is_a_rails_app?
        File.exists?('Gemfile')
      end
    end
  end
end
