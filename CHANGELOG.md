# 2.7.1 / 2016-02-05

* [BUGFIX] Fix Rubycritic's Analysers running twice on the first run

# 2.7.0 / 2016-01-23

* [FEATURE] Open html report with browser (by YingRui Lu)
* [CHANGE] Bump Reek to 3.9.1
* [CHANGE] Bump Rubocop to 0.36 and internal cleanup (preparing for Ruby 2.3)

# 2.6.0 / 2016-01-21

* [FEATURE] Add a minimum score option to the command line interface (by Roberto Schneider)
* [CHANGE] Display the class and module names when the file has no methods

# 2.5.0 / 2016-01-16

* [FEATURE] Add a ConsoleReport format (by Josh Bodah)

# 2.4.1 / 2015-12-27

* [CHANGE] Bump Reek to 3.8.1

# 2.4.0 / 2015-12-26

* [FEATURE] Add progress bar functionality (by Nate Holland)

# 2.3.0 / 2015-11-30

* [FEATURE] Added global score calculation (by Ancor Gonzalez Sosa)
* [CHANGE] Bump Reek dependency to 3.7.1.

# 2.2.0 / 2015-11-20

* [CHANGE] Use `Reeks` default configuration loading.

# 2.1.0 / 2015-11-11

* [CHANGE] Bump flay dependency to 2.6.1.
* [CHANGE] Bump reek dependency to 3.6.0.
* [CHANGE] Bump flog dependency to 4.3.2.

# 2.0.0 / 2015-11-11

* [CHANGE] Drop support for ruby 1.9

# 1.4.0 / 2015-03-14

* [FEATURE] New report in JSON format. Available by using the new CLI option `-f`
* [FEATURE] New CLI option `--suppress-ratings` to suppress ratings (by halostatue)
* [CHANGE] Improve UI, particularly the sortable tables (by crackofdusk)

# 1.3.0 / 2015-02-16

* [FEATURE] New CLI option `--deduplicate-symlinks` to deduplicate symlinks (by LeeXGreen)
* [CHANGE] Update to Reek 1.6.5 (from 1.6.3)
* [CHANGE] Remove ruby2ruby dependency

# 1.2.1 / 2015-01-17

* [FEATURE] Support Ruby 2.2
* [CHANGE] Update to Reek 1.6.3 (from 1.6.0)
* [CHANGE] Update to at least Parser 2.2.0 (from 2.2.0.pre.5)

# 1.2.0 / 2014-12-27

* [FEATURE] Add CI mode that only analyses the last commit
* [FEATURE] Add partial support for Mercurial
* [FEATURE] Allow using RubyCritic programatically
* [CHANGE] Update to Reek 1.6.0 (from 1.3.8)
* [BUGFIX] Fix issue #18 - Prevent encoding issues when using Git

# 1.1.1 / 2014-07-29

* [BUGFIX] Analyse only the files whose paths are specified in the CLI

# 1.1.0 / 2014-07-27

* [FEATURE] Display name of the first module found in a file instead of the file's name

# 1.0.2 / 2014-07-23

* [BUGFIX] Fix issue #8 - Solve a dependency error by requiring at least ruby2ruby 2.1.1

# 1.0.1 / 2014-07-22

* [BUGFIX] Fix issue #6 - Rescue `Parser::SyntaxError` when a file is unparsable

# 1.0.0 / 2014-07-13

* Official Release
