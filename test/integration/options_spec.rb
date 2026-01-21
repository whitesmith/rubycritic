# frozen_string_literal: true

require_relative 'integration_test_helper'

describe 'Command line options' do
  include IntegrationTestHelper

  before do
    setup_aruba
  end

  describe 'return non-zero status on bad option' do
    it 'fails on bad option' do
      rubycritic('--no-such-option')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SCORE_BELOW_MINIMUM
      _(last_command_started.stderr).must_include 'Error: invalid option: --no-such-option'
      _(last_command_started.stdout).must_equal ''
    end
  end

  describe 'display the current version number' do
    it 'shows version' do
      rubycritic('--version')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
      _(last_command_started.stdout).must_include "RubyCritic #{RubyCritic::VERSION}"
    end
  end

  describe 'display the help information' do
    it 'shows help' do
      rubycritic('--help')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
      expected_help = <<~HELP
        Usage: rubycritic [options] [paths]
            -p, --path [PATH]                Set path where report will be saved (tmp/rubycritic by default)
            -b, --branch BRANCH              Set branch to compare
            -t [MAX_DECREASE],               Set a threshold for score difference between two branches (works only with -b)
                --maximum-decrease
            -f, --format [FORMAT]            Report smells in the given format:
                                               html (default; will open in a browser)
                                               json
                                               console
                                               lint
                                             Multiple formats are supported.
                --custom-format [REQUIREPATH]:[CLASSNAME]|[CLASSNAME]
                                             Instantiate a given class as formatter and call report for reporting.
                                             Two ways are possible to load the formatter.
                                             If the class is not autorequired the REQUIREPATH can be given together
                                             with the CLASSNAME to be loaded separated by a :.
                                             Example: rubycritic/markdown/reporter.rb:RubyCritic::MarkDown::Reporter
                                             or if the file is already required the CLASSNAME is enough
                                             Example: RubyCritic::MarkDown::Reporter
                                             Multiple formatters are supported.
            -s, --minimum-score [MIN_SCORE]  Set a minimum score
                --churn-after [DATE]         Only count churn from a certain date.
                                             The date is passed through to version control (currently git only).
                                             Example: 2017-01-01
            -m, --mode-ci [BASE_BRANCH]      Use CI mode (faster, analyses diffs w.r.t base_branch (default: main))
                --deduplicate-symlinks       De-duplicate symlinks based on their final target
                --suppress-ratings           Suppress letter ratings
                --no-browser                 Do not open html report with browser
                --coverage-path [PATH]       SimpleCov coverage will be saved (./coverage by default)
            -v, --version                    Show gem's version
            -h, --help                       Show this message

      HELP
      _(last_command_started.stdout).must_include expected_help
    end
  end
end
