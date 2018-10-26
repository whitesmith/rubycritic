# frozen_string_literal: true

require 'English'
require 'shellwords'

module RubyCritic
  module SourceControlSystem
    class Base
      @@systems = []

      def self.register_system
        @@systems << self
      end

      def self.systems
        @@systems
      end

      def self.create
        supported_system = systems.find(&:supported?)
        if supported_system
          supported_system.new
        else
          puts 'RubyCritic can provide more feedback if you use '\
                "a #{connected_system_names} repository. "\
                'Churn will not be calculated.'
          Double.new
        end
      end

      def self.connected_system_names
        "#{systems[0...-1].join(', ')} or #{systems[-1]}"
      end
    end
  end
end

require 'rubycritic/source_control_systems/double'
require 'rubycritic/source_control_systems/git'
require 'rubycritic/source_control_systems/mercurial'
require 'rubycritic/source_control_systems/perforce'
