RubyCritic
==========

[![Gem Version](https://badge.fury.io/rb/rubycritic.svg)](http://badge.fury.io/rb/rubycritic)
[![Build Status](https://travis-ci.org/whitesmith/rubycritic.svg?branch=master)](https://travis-ci.org/whitesmith/rubycritic)
[![Code Climate](https://codeclimate.com/github/whitesmith/rubycritic/badges/gpa.svg)](https://codeclimate.com/github/whitesmith/rubycritic)

<img src="https://github.com/whitesmith/rubycritic/raw/master/images/logo.png" alt="RubyCritic Icon" align="right" />

RubyCritic is a gem that wraps around static analysis gems such as [Reek][1], [Flay][2] and [Flog][3] to provide a quality report of your Ruby code.

**Table of Contents**

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Usage](#usage)
  + [Analyzer Configuration](#analyzer-configuration)
  + [Alternative Usage Methods](#alternative-usage-methods)
  + [Rake Task](#rake-task)
- [Compatibility](#compatibility)
- [Improving RubyCritic](#improving-rubyCritic)
- [Contributors](#contributors)
- [Credits](#credits)


## Overview

This gem provides features such as:

1. An overview of your project:

  ![RubyCritic overview screenshot](https://github.com/whitesmith/rubycritic/raw/master/images/overview.png)

2. An index of the project files with their respective number of smells:

  ![RubyCritic code index screenshot](https://github.com/whitesmith/rubycritic/raw/master/images/code.png)

3. An index of the smells detected:

  ![RubyCritic smells index screenshot](https://github.com/whitesmith/rubycritic/raw/master/images/smells.png)

4. When analysing code like the following:

  ```ruby
  class Dirty
    def awful(x, y)
      if y
        @screen = widgets.map {|w| w.each {|key| key += 3}}
      end
    end
  end
  ```

  It basically turns something like this:

  ![Reek output screenshot](https://github.com/whitesmith/rubycritic/raw/master/images/reek.png)

  Into something like this:

  ![RubyCritic file code screenshot](https://github.com/whitesmith/rubycritic/raw/master/images/smell-details.png)

5. It uses your source control system (only Git, Mercurial and Perforce
  are currently supported) to compare your currently uncommitted
  changes with your last commit.

  **Warning**: If your code is not as you expect it to be after running
  RubyCritic, please check your source control system stash.

Checkout the `/docs` if you want to read more about our [core metrics](https://github.com/whitesmith/rubycritic/blob/master/docs/core-metrics.md).


## Getting Started

RubyCritic can be installed with the following command:

```bash
$ gem install rubycritic
```

If you'd rather install RubyCritic using Bundler, add this line to your
application's Gemfile:

```ruby
gem "rubycritic", require: false
```

And then execute:

```bash
$ bundle
```


## Usage

Running `rubycritic` with no arguments will analyse all the Ruby files in the
current directory:

```bash
$ rubycritic
```

Alternatively you can pass `rubycritic` a list of files and directories to check:

```bash
$ rubycritic app lib/foo.rb
```

For a full list of the command-line options run:

```bash
$ rubycritic --help
```

| Command flag                        | Description                                                     |
|-------------------------------------|-----------------------------------------------------------------|
| `-v` / `--version`                  | Displays the current version and exits                          |
| `-p` / `--path`                     | Set path where report will be saved (tmp/rubycritic by default) |
| `-f` / `--format`                   | Report smells in the given format(s)<sup>1</sup>                |
| `--custom-format path:classname`    | Load and instantiate custom formatter(s)<sup>2</sup>            |
| `-s` / `--minimum-score`            | Set a minimum score (FLOAT: ex: 96.28), default: 0              |
| `-m` / `--mode-ci`                  | Use CI mode<sup>3</sup>                                         |
| `-b` / `--branch`                   | Set branch to compare                                           |
| `-t` / `--maximum-decrease`         | Threshold for score difference between two branches<sup>4</sup> |
| `--deduplicate-symlinks`            | De-duplicate symlinks based on their final target               |
| `--suppress-ratings`                | Suppress letter ratings                                         |
| `--no-browser`                      | Do not open html report with browser                            |

1. Available output formats:
- `html` (default; will open in a browser)
- `json`
- `console`
- `lint`
2. See [custom formatters docs](/docs/formatters.md)
3. Faster, analyses diffs w.r.t base_branch (default: master), see `-b`
4. Works only with `-b`, default: 0

You also can use a config file. Just create a `.rubycritic.yml` on your project root path.

Here are one example:
```yml
mode_ci:
  enabled: true # default is false
  branch: 'production' # default is master
branch: 'production' # default is master
path: '/tmp/mycustompath' # Set path where report will be saved (tmp/rubycritic by default)
threshhold_score: 10 # default is 0
deduplicate_symlinks: true # default is false
suppress_ratings: true # default is false
no_browser: true # default is false
format: console # Available values are: html, json, console, lint. Default value is html.
minimum_score: 95 # default is 0
paths: # Files to analyse.
  - 'app/controllers/'
  - 'app/models/'
```

### Analyzer Configuration

* [`Reek`](https://github.com/troessner/reek): `RubyCritic` utilizes `Reek`'s default [configuration loading mechanism](https://github.com/troessner/reek#configuration-file).
  This means that if you have an existing `Reek` configuration file, you can just put this into your
  project root and `RubyCritic` will respect this configuration.
* [`flay`](https://github.com/seattlerb/flay): We use `flay`'s default configuration.
* [`flog`](https://github.com/seattlerb/flog): We use `flog`'s default configuration with a couple of [smaller tweaks](https://github.com/whitesmith/rubycritic/blob/master/lib/rubycritic/analysers/helpers/flog.rb#L5):
    * `all`: Forces `flog` to report scores on all classes and methods. Without this option `flog` will only give results up to a certain threshold.
    * `continue`: Makes it so that `flog` does not abort when a ruby file cannot be parsed.
    * `methods`: Configures `flog` to skip code outside of methods. It prevents `flog` from reporting on the "methods" `private` and `protected`. It also prevents `flog` from reporting on Rails methods like `before_action` and `has_many`.


### Alternative Usage Methods

If you're fond of Guard you might like [guard-rubycritic][4]. It automatically analyses your Ruby files as they are modified.

For continuous integration, you can give [Jenkins CI][5] a spin. With it, you can [easily build your own (poor-man's) Code Climate][6]!


### Rake Task

You can use RubyCritic as Rake command in its most simple form like this:

```ruby
require "rubycritic/rake_task"

RubyCritic::RakeTask.new
```

A more sophisticated Rake task that would make use of all available configuration options could look like this:

```ruby
RubyCritic::RakeTask.new do |task|
  # Name of RubyCritic task. Defaults to :rubycritic.
  task.name    = 'something_special'

  # Glob pattern to match source files. Defaults to FileList['.'].
  task.paths   = FileList['vendor/**/*.rb']

  # You can pass all the options here in that are shown by "rubycritic -h" except for
  # "-p / --path" since that is set separately. Defaults to ''.
  task.options = '--mode-ci --format json'

  # Defaults to false
  task.verbose = true
end
```

RubyCritic will try to open the generated report with a browser by default. If you don't want this
you can prevent this behaviour by setting the options correspondingly:

```ruby
RubyCritic::RakeTask.new do |task|
  task.options = '--no-browser'
end
```

## Formatters

See [formatters](docs/formatters.md)

## Compatibility

RubyCritic is supporting Ruby versions:

* 2.3
* 2.4
* 2.5
* 2.6


## Improving RubyCritic

RubyCritic doesn't have to remain a second choice to other code quality analysis services. Together, we can improve it and continue to build on the great code metric tools that are available in the Ruby ecosystem.

Arguably, the [better_errors gem][7] only got popular after receiving a [(pretty awesome) Pull Request][8] that changed its page design.

Similarly, Pull Requests that improve the look and feel of the gem, that tweak the calculation of ratings or that fix existing issues will be most welcome. Just commenting on an issue and giving some insight into how something should work will be appreciated. No contribution is too small.

See RubyCritic's [contributing guidelines](https://github.com/whitesmith/rubycritic/blob/master/CONTRIBUTING.md) about how to proceed.


## Contributors


`RubyCritics` initial author was [Guilherme Simões](https://github.com/guilhermesimoes).

The current core team consists of:

* [Nuno Silva](https://github.com/Onumis)
* [Lucas Mazza](https://github.com/lucasmazza)
* [Timo Rößner](https://github.com/troessner)


## Credits

![Whitesmith](https://github.com/whitesmith/rubycritic/raw/master/images/whitesmith.png)

RubyCritic is maintained and funded by [Whitesmith][9]. Tweet your questions or suggestions to [@Whitesmithco][10].

[1]: https://github.com/troessner/reek
[2]: https://github.com/seattlerb/flay
[3]: https://github.com/seattlerb/flog
[4]: https://github.com/whitesmith/guard-rubycritic
[5]: http://jenkins-ci.org/
[6]: https://github.com/whitesmith/rubycritic/blob/master/docs/building-own-code-climate.md
[7]: https://github.com/charliesome/better_errors
[8]: https://github.com/charliesome/better_errors/pull/22
[9]: http://www.whitesmith.co/
[10]: https://twitter.com/Whitesmithco
