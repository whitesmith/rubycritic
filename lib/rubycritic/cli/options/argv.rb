# frozen_string_literal: true

require 'optparse'

module RubyCritic
  module Cli
    class Options
      # rubocop:disable Metrics/ClassLength
      class Argv
        def initialize(argv)
          @argv = argv
          self.parser = OptionParser.new
        end

        # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
        def parse
          parser.new do |opts|
            opts.banner = 'Usage: rubycritic [options] [paths]'

            opts.on('-p', '--path [PATH]', 'Set path where report will be saved (tmp/rubycritic by default)') do |path|
              @root = path
            end

            opts.on('-b', '--branch BRANCH', 'Set branch to compare') do |branch|
              self.base_branch = String(branch)
              set_current_branch
              self.mode = :compare_branches
            end

            opts.on(
              '-t',
              '--maximum-decrease [MAX_DECREASE]',
              'Set a threshold for score difference between two branches (works only with -b)'
            ) do |threshold_score|
              self.threshold_score = Integer(threshold_score)
            end

            formats = []
            self.formats = formats
            opts.on(
              '-f', '--format [FORMAT]',
              %i[html json console lint],
              'Report smells in the given format:',
              '  html (default; will open in a browser)',
              '  json',
              '  console',
              '  lint',
              'Multiple formats are supported.'
            ) do |format|
              formats << format
            end

            formatters = []
            self.formatters = formatters
            opts.on(
              '--custom-format [REQUIREPATH]:[CLASSNAME]|[CLASSNAME]',
              'Instantiate a given class as formatter and call report for reporting.',
              'Two ways are possible to load the formatter.',
              'If the class is not autorequired the REQUIREPATH can be given together',
              'with the CLASSNAME to be loaded seperated by a :.',
              'Example: rubycritic/markdown/reporter.rb:RubyCritic::MarkDown::Reporter',
              'or if the file is already required the CLASSNAME is enough',
              'Example: RubyCritic::MarkDown::Reporter',
              'Multiple formatters are supported.'
            ) do |formatter|
              formatters << formatter
            end

            opts.on('-s', '--minimum-score [MIN_SCORE]', 'Set a minimum score') do |min_score|
              self.minimum_score = Float(min_score)
            end

            opts.on('-m', '--mode-ci [BASE_BRANCH]',
                    'Use CI mode (faster, analyses diffs w.r.t base_branch (default: master))') do |branch|
              self.base_branch = branch || 'master'
              set_current_branch
              self.mode = :ci
            end

            opts.on('--deduplicate-symlinks', 'De-duplicate symlinks based on their final target') do
              self.deduplicate_symlinks = true
            end

            opts.on('--suppress-ratings', 'Suppress letter ratings') do
              self.suppress_ratings = true
            end

            opts.on('--no-browser', 'Do not open html report with browser') do
              self.no_browser = true
            end

            opts.on_tail('-v', '--version', "Show gem's version") do
              self.mode = :version
            end

            opts.on_tail('-h', '--help', 'Show this message') do
              self.mode = :help
            end
          end.parse!(@argv)
        end

        def to_h
          {
            mode: mode,
            root: root,
            formats: formats,
            formatters: formatters,
            deduplicate_symlinks: deduplicate_symlinks,
            paths: paths,
            suppress_ratings: suppress_ratings,
            help_text: parser.help,
            minimum_score: minimum_score,
            no_browser: no_browser,
            base_branch: base_branch,
            feature_branch: feature_branch,
            threshold_score: threshold_score
          }
        end
        # rubocop:enable Metrics/MethodLength,Metrics/AbcSize

        private

        attr_accessor :mode, :root, :formats, :formatters, :deduplicate_symlinks,
                      :suppress_ratings, :minimum_score, :no_browser,
                      :parser, :base_branch, :feature_branch, :threshold_score
        def paths
          @argv unless @argv.empty?
        end

        def set_current_branch
          self.feature_branch = SourceControlSystem::Git.current_branch
        end
      end
      # rubocop:enable Metrics/ClassLength
    end
  end
end
