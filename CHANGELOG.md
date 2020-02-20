# master [(unreleased)](https://github.com/whitesmith/rubycritic/compare/v4.4.1...master)

# v4.4.1 / 2020-02-20 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.4.0...v4.4.1)

* [CHANGE] Rewrite how churn is calculated to make it faster

# v4.4.0 / 2020-02-15 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.3.3...v4.4.0)

* [FEATURE] Take into account the `.flayignore` file (by [@Flink][])

# v4.3.3 / 2020-01-31 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.3.2...v4.3.3)

* [BUGFIX] Relax constraint on `simplecov` gem (by [@etagwerker][])

# v4.3.2 / 2020-01-27 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.3.1...v4.3.2)

* [BUGFIX] Relax constraint on `parser` gem (by [@lloydwatkin][])

# v4.3.1 / 2019-12-30 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.3.0...v4.3.1)

* [BUGFIX] Fixes NoMethodError on RubyCritic::SourceControlSystem::Git.switch_branch (by [@eitoball][])

# v4.3.0 / 2019-12-26 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.2.2...v4.3.0)

* [FEATURE] Show which files are uncommited in git (by [@GeoffTidey][])
* [BUGFIX] Fixes TypeError when `.resultset.json` is not found (by [@etagwerker][])

# v4.2.2 / 2019-11-12 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.2.1...v4.2.2)

* [BUGFIX] Fix deprecation warnings related to Minitest 6 (by [@jsantos][])
* [BUGFIX] Expand Churn vs. Complexity chart to full-width on small screen (by [@teohm][])

# v4.2.1 / 2019-10-29 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.2.0...v4.2.1)

* [BUGFIX] Fix Color coding of files in Coverage section (by [@etagwerker][])

# v4.2.0 / 2019-10-22 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.1.0...v4.2.0)

* [BUGFIX] Fix CSS alignment of columns for when --suppress-ratings is used on the code page (by [@jbampton][])
* [BUGFIX] Fix typo in example `.rubycritic.yml` (by [@Adre][])
* [BUGFIX] Fix YAML configuration file 'formats' processing (by [@cvoltz][])
* [FEATURE] Add Markdown linting to the Travis build by using the Rubygem `markdownlint` (by [@jbampton][])
* [FEATURE] Add new report for SimpleCov (by [@etagwerker][])

# v4.1.0 / 2019-06-07 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.0.2...v4.1.0)

* [BUGFIX] Assorted fixes in HTML report (by [@jbampton][])
* [BUGFIX] Fix duplicate HTML5 DOCTYPE (by [@jbampton][])
* [BUGFIX] Config options getting overwritten by nil argv options (by [@nathanbwright][])
* [CHANGE] Update Reek dependency to '~> 5.0', '< 6.0' (by [@leksster][])

# 4.0.2 / 2019-03-14 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.0.1...v4.0.2)

* [BUGFIX] Fix generating the default html report (by [@lightalloy][])

# 4.0.1 / 2019-03-12 [(commits)](https://github.com/whitesmith/rubycritic/compare/v4.0.0...v4.0.1)

* [FEATURE] Allow passing formatters from the outside (by [@marcgrimme][] and [@onumis][])
* [CHANGE] Fix aruba deprecation warning

# 4.0.0 / 2019-02-27 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.5.1...v4.0.0)

* [FEATURE] Allow generating reports in multiple formats in one run (by [@katafrakt])
* [FEATURE] Allow to accept a config file (by [@mfbmina])
* [CHANGE] Update `reek` to 5.3 (by [@taitran19][] and [@onumis][])
* [CHANGE] Update `parser` to 2.6.0 (by [@onumis][])
* [CHANGE] Update `tty-which` to 0.4.0 (by [@onumis][])
* [CHANGE] Drop support for ruby 2.1 and 2.2 (by [@onumis][])
* [CHANGE] Fix rubocop offenses (by [@AllanSiqueira][] and [@harman28][])

# 3.5.2 / 2018-09-27 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.5.1...v3.5.2)

* [BUGFIX] Use a better uncommitted changes detection for git (by [@onumis][])

# 3.5.1 / 2018-09-05 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.5.0...v3.5.1)

* [BUGFIX] Fix branches score comparison when threshold is 0 (by [@antoineLeclercq][])

# 3.5.0 / 2018-09-03 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.4.0...v3.5.0)

* [CHANGE] Add ability to compare only the modified files between two branches. Refactored option `--mode-ci`, added `--branch` and `--maximum-decrease` (by [@HemanthMudalaiah][])
* [CHANGE] Optimized all images (by [@SuperSandro2000][])
* [BUGFIX] Fixed opening report in chrome on windows (by [@SuperSandro2000][])
* [BUGFIX] Fixed churn on windows (by [@SuperSandro2000][])
* [BUGFIX] Fixed gem not installing under restricted windows environments (by [@onumis][])

# 3.4.0 / 2018-03-22 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.3.0...v3.4.0)

* [CHANGE] Update `rubocop` to 0.51.0 (by [@olleolleolle][])
* [CHANGE] Update `parser` to 2.5.0 (by [@joshrpowell][])
* [CHANGE] Update `rainbow` to 3.0 (by [@joshrpowell][])
* [CHANGE] Update `rubocop` to 0.53.0 (by [@joshrpowell][])
* [BUGFIX] Fix wrong label for churn in the code file template (by [@nbekirov][])

# 3.3.0 / 2017-10-10 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.2.3...v3.3.0)

* [FEATURE] Add lint format similar to Golint (by [@nightscape][])
* [CHANGE] Update `cucumber` to 3.0 (by [@onumis][])
* [CHANGE] Update `rake` to 12.0 (by [@onumis][])
* [CHANGE] Update `rubocop` to 0.50.0 (by [@onumis][])
* [CHANGE] Accepting floating point values from Flog (by [@onumis][])

# 3.2.3 / 2017-05-31 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.2.2...v3.2.3)

* [BUGFIX] Fix rendering of churn chart in large codebases. (by [@ochagata][])

# 3.2.2 / 2017-05-18 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.2.1...v3.2.2)

* [CHANGE] Relax dependency of parser gem (by [@yuku-t][])
* [BUGFIX] Only scroll Y axis when visiting page with anchor tag (by [@georgedrummond][])

# 3.2.1 / 2017-05-13 [(commits)](https://github.com/whitesmith/rubycritic/compare/v3.2.0...v3.2.1)

* [CHANGE] Update `rubocop` to 0.48.x from 0.47.1 (by [@koic][] and [@Onumis][])
* [BUGFIX] Nest ordered list so we don't render errors as line numbers (by [@georgedrummond][])

# 3.2.0 / 2017-03-24

* [CHANGE] Update `rubocop` to 0.47.1 from 0.42.0 (by [@jdickey][])
* [CHANGE] Update for Ruby 2.4.0 compatibility; update `parser` gem to 2.4.0 (by [@jdickey][])
* [CHANGE] Improve YARD documentation (by [@olleolleolle][] and [@tejasbubane][])

# 3.1.3 / 2016-12-19

* [BUGFIX] Fix crash with the usage of an unavailable color in "rainbow" gem  (by [@thedrow][])

# 3.1.2 / 2016-12-17

* [BUGFIX] Fix errors when no source-control is found (by [@tejasbubane][])
* [BUGFIX] Fix lack of the GPA chart when used with rake/rails (by [@hoshinotsuyoshi][])
* [BUGFIX] Fix code navigation links in the new UI (by [@rohitcy][])

# 3.1.1 / 2016-12-02

* [FEATURE] Implement search and filter on code and smells view (by [@rohitcy][])
* [CHANGE] Use Ruby's File instead of `wc` system command (by [@tejasbubane][])
* [CHANGE] Add MRI 2.3.3 compatibility by updating `parser` to v2.3.3.1 (by [@josephpage][])
* [BUGFIX] Fix code navigation links in the new UI (by [@rohitcy][])
* [BUGFIX] Add missing method 'head_reference' for Perforce source control (by [@Rataah][])

# 3.1.0 / 2016-11-23

* [FEATURE] Support for Perforce source control system (by [@Rataah][])
* [CHANGE] New Web UI (by [@tejasbubane][])
* [CHANGE] Significant improvements to documentation (by [@olleolleolle][])
* [CHANGE] Typo / consistency updates to features and tests (by [@olleolleolle][])
* [CHANGE] Fix test warnings and upgrade 'parser' to '2.3.1.4' (by [@tejasbubane][])
* [BUGFIX] Increase the turboThreshold of Highcharts so that it renders nicely even with lots of data (by [@victormartins][])

# 3.0.0 / 2016-11-01

* [CHANGE] Set required ruby version to 2.1 (by [@Onumis][])
* [BUGFIX] Respect the .reek configuration file (by [@mereghost][])

# 2.9.4 / 2016-09-16

* [CHANGE] Update Reek, flog, flay (by [@bglusman][])

# 2.9.3 / 2016-08-17

* [FEATURE] Save json report to file  (by [@NickTroy][])
* [CHANGE] Rename Rubycritic to RubyCritic (by [@troessner][])

# 2.9.2 / 2016-07-01

* [CHANGE] Upgrade rubocop to 0.41.1 (by [@nijikon][])
* [CHANGE] Upgrade flog to 4.4.0 (by [@nijikon][])
* [CHANGE] Upgrade flay to 2.8.0 (by [@nijikon][])
* [CHANGE] Upgrade Reek to 4.1.0 and Parser to 2.3.1.2 (by [@y-yagi][])

# 2.9.1 / 2016-05-16

* [CHANGE] Upgrade 'parser' to 2.3.1.0 (by [@y-yagi][])
* [CHANGE] Upgrade 'reek' to 4.0.2 (by [@onumis][])
* [CHANGE] Upgrade 'rubocop' to 0.40.0 (by [@onumis][])

# 2.9.0 / 2016-04-12

* [FEATURE] Add links to Flay and Flog code smells documentation (by [@ragesoss][])
* [FEATURE] Documentation updates (by [@troessner][])
* [CHANGE] Bump Rubocop to 0.39.0 (by [@nijikon][])
* [CHANGE] Bump Reek to 4.0.1 (by [@nijikon][])
* [CHANGE] Drop support for Ruby 2.0 (by [@nijikon][])

# 2.8.0 / 2016-02-29

* [FEATURE] Add link to Reek's code smells documentation (by [@danielmbarlow][])
* [FEATURE] Make RubyCritic usable as Rake Task (by [@troessner][])
* [CHANGE] Bump Rubocop to 0.37.2 (by [@nijikon][])
* [CHANGE] Bump Flay to 2.7.0 (by [@nijikon][])
* [CHANGE] Bump Reek to 3.11 (by [@nijikon][])
* [CHANGE] Add explicit runtime dependency on ruby_parser ('~> 3.8') (by [@Onumis][])

# 2.7.1 / 2016-02-09

* [CHANGE] Bump Reek to 3.10.1 (by [@nijikon][])
* [BUGFIX] Analyse only the files whose paths are specified in the CLI (by [@Onumis][])

# 2.7.0 / 2016-01-23

* [FEATURE] Open html report with browser (by [@superiorlu][])
* [CHANGE] Bump Reek to 3.9.1
* [CHANGE] Bump Rubocop to 0.36 and internal cleanup (preparing for Ruby 2.3)

# 2.6.0 / 2016-01-21

* [FEATURE] Add a minimum score option to the command line interface (by [@RobertoSchneiders][])
* [CHANGE] Display the class and module names when the file has no methods

# 2.5.0 / 2016-01-16

* [FEATURE] Add a ConsoleReport format (by [@jbodah][])

# 2.4.1 / 2015-12-27

* [CHANGE] Bump Reek to 3.8.1

# 2.4.0 / 2015-12-26

* [FEATURE] Add progress bar functionality (by [@natesholland][])

# 2.3.0 / 2015-11-30

* [FEATURE] Added global score calculation (by [@ancorgs][])
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
* [FEATURE] New CLI option `--suppress-ratings` to suppress ratings (by [@halostatue][])
* [CHANGE] Improve UI, particularly the sortable tables (by [@crackofdusk][])

# 1.3.0 / 2015-02-16

* [FEATURE] New CLI option `--deduplicate-symlinks` to deduplicate symlinks (by [@LeeXGreen][])
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

[@LeeXGreen]: https://github.com/LeeXGreen
[@crackofdusk]: https://github.com/crackofdusk
[@halostatue]: https://github.com/halostatue
[@ancorgs]: https://github.com/ancorgs
[@natesholland]: https://github.com/natesholland
[@jbodah]: https://github.com/jbodah
[@RobertoSchneiders]: https://github.com/RobertoSchneiders
[@superiorlu]: https://github.com/superiorlu
[@Onumis]: https://github.com/Onumis
[@nijikon]: https://github.com/nijikon
[@troessner]: https://github.com/troessner
[@danielmbarlow]: https://github.com/danielmbarlow
[@ragesoss]: https://github.com/ragesoss
[@y-yagi]: https://github.com/y-yagi
[@NickTroy]: https://github.com/NickTroy
[@bglusman]: https://github.com/bglusman
[@mereghost]: https://github.com/mereghost
[@victormartins]: https://github.com/victormartins
[@tejasbubane]: https://github.com/tejasbubane
[@olleolleolle]: https://github.com/olleolleolle
[@Rataah]: https://github.com/Rataah
[@rohitcy]: https://github.com/rohitcy
[@josephpage]: https://github.com/josephpage
[@hoshinotsuyoshi]: https://github.com/hoshinotsuyoshi
[@thedrow]: https://github.com/thedrow
[@jdickey]: https://github.com/jdickey
[@koic]: https://github.com/koic
[@georgedrummond]: https://github.com/georgedrummond
[@yuku-t]: https://github.com/yuku-t
[@ochagata]: https://github.com/ochagata
[@nightscape]: https://github.com/nightscape
[@nbekirov]: https://github.com/nbekirov
[@joshrpowell]: https://github.com/joshrpowell
[@HemanthMudalaiah]: https://github.com/HemanthMudalaiah
[@SuperSandro2000]: https://github.com/SuperSandro2000
[@antoineLeclercq]: https://github.com/antoineLeclercq
[@mfbmina]: https://github.com/mfbmina
[@taitran19]: https://github.com/taitran19
[@AllanSiqueira]: https://github.com/AllanSiqueira
[@harman28]: https://github.com/harman28
[@lightalloy]: https://github.com/lightalloy
[@jbampton]: https://github.com/jbampton
[@nathanbwright]: https://github.com/nathanbwright
[@leksster]: https://github.com/leksster
[@etagwerker]: https://github.com/etagwerker
[@cvoltz]: https://github.com/cvoltz
[@Adre]: https://github.com/Adre
[@GeoffTidey]: https://github.com/GeoffTidey
[@lloydwatkin]: https://github.com/lloydwatkin
[@Flink]: https://github.com/Flink
