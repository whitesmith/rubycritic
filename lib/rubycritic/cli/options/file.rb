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
            coverage_path: coverage_path,
            formats: formats,
            deduplicate_symlinks: deduplicate_symlinks?,
            paths: paths,
            suppress_ratings: suppress_ratings?,
            minimum_score: minimum_score,
            no_browser: no_browser?,
            base_branch: base_branch,
            feature_branch: feature_branch,
            threshold_score: threshold_score
          }
        end
        # rubocop:enable Metrics/MethodLength

        private

        def base_branch
          return options.dig('mode_ci', 'branch') || 'main' if options.dig('mode_ci', 'enabled').to_s == 'true'

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

        def coverage_path
          options['coverage_path']
        end

        # The YAML key is `maximum_decrease` (matching the `--maximum-decrease`
        # CLI flag). The legacy `threshold_score` key is still honoured for
        # backward compatibility but is deprecated. When both are present, the
        # new `maximum_decrease` key takes precedence.
        def threshold_score
          warn_threshold_score_deprecation if options.key?('threshold_score')

          options.fetch('maximum_decrease') { options['threshold_score'] }
        end

        def warn_threshold_score_deprecation
          warn(
            '[DEPRECATION] The `threshold_score` key in .rubycritic.yml is deprecated ' \
            'and will be removed in a future release. Please use `maximum_decrease` instead.'
          )
        end

        def deduplicate_symlinks?
          value_for?(options['deduplicate_symlinks'])
        end

        def suppress_ratings?
          value_for?(options['suppress_ratings'])
        end

        def no_browser?
          value_for?(options['no_browser'])
        end

        def formats
          formats = Array(options['formats'])
          formats_to_check = %w[html json console lint]
          formats.select do |format|
            formats_to_check.include?(format)
          end.map(&:to_sym)
        end

        def minimum_score
          options['minimum_score']
        end

        def paths
          options['paths']
        end

        def value_for?(value)
          value = value.to_s
          value == 'true' unless value.empty?
        end
      end
    end
  end
end
