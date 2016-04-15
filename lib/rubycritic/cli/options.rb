require 'optparse'
require 'rubycritic/browser'

module Rubycritic
  module Cli
    class Options
      def initialize(argv)
        @argv = argv
        @parser = OptionParser.new
      end

      # rubocop:disable Metrics/MethodLength
      def parse
        @parser.new do |opts|
          opts.banner = 'Usage: rubycritic [options] [paths]'

          opts.on('-p', '--path [PATH]', 'Set path where report will be saved (tmp/rubycritic by default)') do |path|
            @root = path
          end

          opts.on(
            '-f', '--format [FORMAT]',
            [:html, :json, :console],
            'Report smells in the given format:',
            '  html (default)',
            '  json',
            '  console'
          ) do |format|
            @format = format
          end

          opts.on('-s', '--minimum-score [MIN_SCORE]', 'Set a minimum score') do |min_score|
            @minimum_score = Integer(min_score)
          end

          opts.on('-m', '--mode-ci', 'Use CI mode (faster, but only analyses last commit)') do
            @mode = :ci
          end

          opts.on('--deduplicate-symlinks', 'De-duplicate symlinks based on their final target') do
            @deduplicate_symlinks = true
          end

          opts.on('--suppress-ratings', 'Suppress letter ratings') do
            @suppress_ratings = true
          end

          opts.on('--no-browser', 'Do not open html report with browser') do
            @no_browser = true
          end

          opts.on(
            '-r', '--for-rails', 'Generates report inside your rails application',
            '  Ignores some given parameters:',
            '  (-p, --path, -f, --format)'
          ) do
            @format = :html
            @assets_folder = "app"
            @assets_path = "rubycritic"
            @root = "app/views/rubycritic"
            @for_rails = true
          end

          opts.on_tail('-v', '--version', "Show gem's version") do
            @mode = :version
          end

          opts.on_tail('-h', '--help', 'Show this message') do
            @mode = :help
          end
        end.parse!(@argv)
        self
      end

      def to_h
        {
          mode: @mode,
          root: @root,
          format: @format,
          deduplicate_symlinks: @deduplicate_symlinks,
          paths: paths,
          suppress_ratings: @suppress_ratings,
          help_text: @parser.help,
          minimum_score: @minimum_score || 0,
          no_browser: @no_browser,
          assets_folder: @assets_folder,
          javascripts_path: @assets_path || "javascripts/rubycritic",
          stylesheets_path: @assets_path || "stylesheets/rubycritic",
          for_rails: @for_rails
        }
      end

      private

      def paths
        if @argv.empty?
          ['.']
        else
          @argv
        end
      end
    end
  end
end
