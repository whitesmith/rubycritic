Feature: RubyCritic can be controlled using command-line options
  In order to change RubyCritic's default behaviour
  As a developer
  I want to supply options on the command line

  Scenario: return non-zero status on bad option
    When I run rubycritic --no-such-option
    Then the exit status indicates an error
    And it reports the error "Error: invalid option: --no-such-option"
    And there is no output on stdout

  Scenario: display the current version number
    When I run rubycritic --version
    Then it succeeds
    And it reports the current version

  Scenario: display the help information
    When I run rubycritic --help
    Then it succeeds
    And it reports:
      """
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
          -m, --mode-ci [BASE_BRANCH]      Use CI mode (faster, analyses diffs w.r.t base_branch (default: master))
              --deduplicate-symlinks       De-duplicate symlinks based on their final target
              --suppress-ratings           Suppress letter ratings
              --no-browser                 Do not open html report with browser
              --coverage-path [PATH]       SimpleCov coverage will be saved (./coverage by default)
          -v, --version                    Show gem's version
          -h, --help                       Show this message

      """
