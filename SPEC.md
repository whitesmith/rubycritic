Ruby Critic
===========

Ruby Critic is a tool that detects and reports smells in Ruby code.

Inspired by [RuboCop][1], [Rails Best Practices][2] and [Code Climate][3], Ruby Critic aims to better help you refactor your code. By making use of Ruby's rich ecosystem of code metrics tools, Ruby Critic generates high-quality visualizations and insightful code quality reports.

[1]: https://github.com/bbatsov/rubocop/
[2]: https://github.com/railsbp/rails_best_practices
[3]: https://codeclimate.com/

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

Options
-------

To specify an output file for the results:

```bash
$ rubycritic -o output_file
```

The output format is determined by the file extension or by using the `-f` option. Current options are: `text`, `html`, `yaml` and `json`.
