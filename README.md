RubyCritic
===========

RubyCritic is a gem that wraps around static analysis gems such as [Reek][1]
and [Flay][2] to provide a quality report of your Ruby code.

For example, given the following code:

```ruby
class Dirty
  def awful(x, y, offset = 0, log = false)
    puts @screen.title
    @screen = widgets.map {|w| w.each {|key| key += 3}}
    puts @screen.contents
  end
end
```

It turns something like this:

![Reek output screenshot](http://i.imgur.com/xLtEDOb.png)

Into this:

![RubyCritic output screenshot](http://i.imgur.com/SpZ2SJN.png)

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
