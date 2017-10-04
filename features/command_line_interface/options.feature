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
          -f, --format [FORMAT]            Report smells in the given format:
                                             html (default; will open in a browser)
                                             json
                                             console
                                             lint
          -s, --minimum-score [MIN_SCORE]  Set a minimum score
          -m, --mode-ci                    Use CI mode (faster, but only analyses last commit)
              --deduplicate-symlinks       De-duplicate symlinks based on their final target
              --suppress-ratings           Suppress letter ratings
              --no-browser                 Do not open html report with browser
          -v, --version                    Show gem's version
          -h, --help                       Show this message

      """
