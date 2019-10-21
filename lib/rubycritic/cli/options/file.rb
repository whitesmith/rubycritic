# frozen_string_literal: true

require 'yaml'

module RubyCritic
  module Cli
    class Options
      class File
        attr_reader :filename, :options

        def initialize(filename = './.rubycritic.yml')
          @filename = filename
          @options = {}
        end

        def parse
          @options = YAML.load_file(filename) if ::File.file?(filename)
        end

        # rubocop:disable Metrics/MethodLength
        def to_h
          {
            mode: mode,
            root: root,
            formats: formats,
            deduplicate_symlinks: deduplicate_symlinks,
            paths: paths,
            suppress_ratings: suppress_ratings,
            minimum_score: minimum_score,
            no_browser: no_browser,
            base_branch: base_branch,
            feature_branch: feature_branch,
            threshold_score: threshold_score
          }
        end
        # rubocop:enable Metrics/MethodLength

        private

        def base_branch
          return options.dig('mode_ci', 'branch') || 'master' if options.dig('mode_ci', 'enabled').to_s == 'true'

          options['branch']
        end

        def mode
          if options.dig('mode_ci', 'enabled').to_s == 'true'
            :ci
          elsif base_branch
            :compare_branches
          end
        end

        def feature_branch
          SourceControlSystem::Git.current_branch if base_branch
        end

        def root
          options['path']
        end

        def threshold_score
          options['threshold_score']
        end

        def deduplicate_symlinks
          value_for(options['deduplicate_symlinks'])
        end

        def suppress_ratings
          value_for(options['suppress_ratings'])
        end

        def no_browser
          value_for(options['no_browser'])
        end

        def formats
          formats = Array(options['formats'])
          formats.select do |format|
            %w[html json console lint].include?(format)
          end.map(&:to_sym)
        end

        def minimum_score
          options['minimum_score']
        end

        def paths
          options['paths']
        end

        def value_for(value)
          value = value.to_s
          value == 'true' unless value.empty?
        end
      end
    end
  end
end
