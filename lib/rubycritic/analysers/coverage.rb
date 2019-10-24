# frozen_string_literal: true

require 'rubycritic/colorize'
require 'json'
require 'simplecov'

module RubyCritic
  module Analyser
    class Coverage
      include Colorize

      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
        @result = results.first
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.coverage = find_coverage_percentage(analysed_module)
          print green '.'
        end
        puts ''
      end

      def to_s
        'simple_cov'
      end

      private

      def find_coverage_percentage(analysed_module)
        source_file = find_source_file(analysed_module)

        return 0 unless source_file

        source_file.covered_percent
      end

      def find_source_file(analysed_module)
        return unless @result

        needle = File.join(SimpleCov.root, analysed_module.path)

        @result.source_files.detect { |file| file.filename == needle }
      end

      # The path to the .resultset.json cache file
      def resultset_path
        File.join(SimpleCov.coverage_path, '.resultset.json')
      end

      def resultset_writelock
        File.join(SimpleCov.coverage_path, '.resultset.json.lock')
      end

      # Loads the cached resultset from JSON and returns it as a Hash,
      # caching it for subsequent accesses.
      def resultset
        @resultset ||= begin
          if (data = stored_data)
            begin
              JSON.parse(data) || {}
            rescue JSON::ParserError => err
              puts "Error: Loading .resultset.json: #{err.message}"
              {}
            end
          else
            {}
          end
        end
      end

      # Returns the contents of the resultset cache as a string or if the file is missing or empty nil
      def stored_data
        synchronize_resultset do
          return unless File.exist?(resultset_path)

          return unless (data = File.read(resultset_path))

          return if data.length < 2

          data
        end
      end

      # Ensure only one process is reading or writing the resultset at any
      # given time
      def synchronize_resultset
        # make it reentrant
        return yield if defined?(@resultset_locked) && @resultset_locked == true

        return yield unless File.exist?(resultset_writelock)

        begin
          @resultset_locked = true
          File.open(resultset_writelock, 'w+') do |file|
            file.flock(File::LOCK_EX)
            yield
          end
        ensure
          @resultset_locked = false
        end
      end

      # Gets the resultset hash and re-creates all included instances
      # of SimpleCov::Result from that.
      # All results that are above the SimpleCov.merge_timeout will be
      # dropped. Returns an array of SimpleCov::Result items.
      def results
        array = []
        resultset.each do |command_name, data|
          array << ::SimpleCov::Result.from_hash(command_name => data)
        end
        array
      end
    end
  end
end
