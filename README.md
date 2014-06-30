RubyCritic
===========

[![Gem Version](https://badge.fury.io/rb/rubycritic.svg)](http://badge.fury.io/rb/rubycritic)
[![Build Status](https://travis-ci.org/whitesmith/rubycritic.svg?branch=master)](https://travis-ci.org/whitesmith/rubycritic)
[![Code Climate](http://img.shields.io/codeclimate/github/whitesmith/rubycritic.svg)](https://codeclimate.com/github/whitesmith/rubycritic)

RubyCritic is a gem that wraps around static analysis gems such as [Reek][1]
and [Flay][2] to provide a quality report of your Ruby code.

This gem provides features such as:

1. An overview of your project:

  ![RubyCritic overview screenshot](http://i.imgur.com/OrOflfj.png)

2. An index of the project files with their respective number of smells:

  ![RubyCritic code index screenshot](http://i.imgur.com/0ETNrX7.png)

3. An index of the smells detected:

  ![RubyCritic smells index screenshot](http://i.imgur.com/5CpPt9v.png)

4. Finally, when analysing code like the following:

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

  ![Reek output screenshot](http://i.imgur.com/tCgZX9I.png)

  Into something like this:

  ![RubyCritic file code screenshot](http://i.imgur.com/KLVrhMm.png)

Installation
------------

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

[1]: https://github.com/troessner/reek
[2]: https://github.com/seattlerb/flay
