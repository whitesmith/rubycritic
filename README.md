RubyCritic
==========

[![Gem Version](https://badge.fury.io/rb/rubycritic.svg)](http://badge.fury.io/rb/rubycritic)
[![Build Status](https://travis-ci.org/whitesmith/rubycritic.svg?branch=master)](https://travis-ci.org/whitesmith/rubycritic)
[![Code Climate](https://codeclimate.com/github/whitesmith/rubycritic/badges/gpa.svg)](https://codeclimate.com/github/whitesmith/rubycritic)

<img src="http://i.imgur.com/66HACCD.png" alt="RubyCritic Icon" align="right" />
RubyCritic is a gem that wraps around static analysis gems such as [Reek][1], [Flay][2] and [Flog][3] to provide a quality report of your Ruby code.

This gem provides features such as:

1. An overview of your project:

  ![RubyCritic overview screenshot](http://i.imgur.com/oiE5O3X.png)

2. An index of the project files with their respective number of smells:

  ![RubyCritic code index screenshot](http://i.imgur.com/a0GCn48.png)

3. An index of the smells detected:

  ![RubyCritic smells index screenshot](http://i.imgur.com/PvkFEe3.png)

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

  ![Reek output screenshot](http://i.imgur.com/5G2zPIC.png)

  Into something like this:

  ![RubyCritic file code screenshot](http://i.imgur.com/RNzXewk.png)

5. It uses your source control system (only Git is supported for now) to
  compare your currently uncommitted changes with your last commit.

  **Warning**: If your code is not as you expect it to be after running
  RubyCritic, please check your source control system stash.

Getting Started
---------------

RubyCritic can be installed with the following command:

```bash
$ gem install rubycritic
```

If you'd rather install RubyCritic using Bundler, add this line to your
application's Gemfile:

```ruby
gem "rubycritic", :require => false
```

And then execute:

```bash
$ bundle
```

Usage
-----

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

| Command flag             | Description                                           |
|--------------------------|-------------------------------------------------------|
| `-v/--version`           | Displays the current version and exits                |
| `-p/--path`              | Sets the output directory (tmp/rubycritic by default) |
| `--mode-ci`              | Uses CI mode (faster, but only analyses last commit)  |
| `--deduplicate-symlinks` | De-duplicate symlinks based on their final target     |
| `--suppress-ratings`     | Suppress letter ratings                               |


Rake Task
---------
If you want to integrate `rubycritic` into your `Rakefile` just include the below snippet
to get a rake task called `rubycritic`.

```ruby
require "rubycritic/rake_task"

Rubycritic::RakeTask.new do |task|
  task.paths = "lib"
end
```

Alternative Usage Methods
-------------------------

If you're fond of Guard you might like [guard-rubycritic][4]. It automatically analyses your Ruby files as they are modified.

For continuous integration, you can give [Jenkins CI][5] a spin. With it, you can [easily build your own (poor-man's) Code Climate][6]!

Compatibility
---------------

RubyCritic is supporting:

* 2.0
* 2.1
* 2.2

Note that we do not support Ruby 1.9 anymore.

If you're still on ruby 1.9 you'll have to use the last version of RubyCritic that supports it, which would be [1.4.0](https://github.com/whitesmith/rubycritic/tree/v1.4.0).

Improving RubyCritic
--------------------

RubyCritic doesn't have to remain a second choice to other code quality analysis services. Together, we can improve it and continue to build on the great code metric tools that are available in the Ruby ecosystem.

Arguably, the [better_errors gem][7] only got popular after receiving a [(pretty awesome) Pull Request][8] that changed its page design.

Similarly, Pull Requests that improve the look and feel of the gem, that tweak the calculation of ratings or that fix existing issues will be most welcome. Just commenting on an issue and giving some insight into how something should work will be appreciated. No contribution is too small.

See RubyCritic's [contributing guidelines](CONTRIBUTING.md) about how to proceed.

Credits
-------

![Whitesmith](http://i.imgur.com/Si2l3kd.png)

RubyCritic is maintained and funded by [Whitesmith][9]. Tweet your questions or suggestions to [@Whitesmithco][10].

[1]: https://github.com/troessner/reek
[2]: https://github.com/seattlerb/flay
[3]: https://github.com/seattlerb/flog
[4]: https://github.com/whitesmith/guard-rubycritic
[5]: http://jenkins-ci.org/
[6]: https://github.com/whitesmith/rubycritic/wiki/Building-your-own-Code-Climate
[7]: https://github.com/charliesome/better_errors
[8]: https://github.com/charliesome/better_errors/pull/22
[9]: http://www.whitesmith.co/
[10]: https://twitter.com/Whitesmithco
