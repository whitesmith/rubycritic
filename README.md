Ruby Critic
===========

Ruby Critic is a tool that detects and reports smells in Ruby code.

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem "rubycritic"
```

And then execute:

```bash
$ bundle
```

Or just install it yourself:

```bash
$ gem install rubycritic
```

Usage
-----

Running `rubycritic` with no arguments will check all Ruby source files in the
current directory:

```bash
$ rubycritic
```

Alternatively you can pass `rubycritic` a list of files and directories to check:

```bash
$ rubycritic app lib/foo.rb
```
