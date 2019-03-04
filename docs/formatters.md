# Concept of formatters

The formatters goal is to allow to extract the logic around the representation of each rubycritic run from the gathering of results.
By delegating to a formatter you can write your own *custom* report for rubycritic and being indepedent on the logic.

## Formatters interface

The formatters are nothing more than a class similar to those on [report/generator](/lib/rubycritic/generators).
The report generator must accept an array of `analysed_modules` when initialized, and respond to `#generate_report`, for example:

``` ruby
class MyFormatter
  def initialize(analysed_modules)
    ..
    @analysed_modules = analysed_modules
    ..
  end

  def generate_report
    .. # do whatever you want with the analysed_modules model
  end
end
```

The results will be passed through the [analysed_modules_collection class](/lib/rubycritic/core/analysed_modules_collection.rb).
The `generate_report` method is called to actually generate the report.

## Examples

### Badges

See [rubycritic-small-badge](https://github.com/MarcGrimme/rubycritic-small-badge/). This badge could look as follows:

[![RubyCritic](https://marcgrimme.github.io/rubycritic-small-badge/badges/rubycritic_badge_score.svg)](https://marcgrimme.github.io/rubycritic-small-badge/tmp/rubycritic/overview.html)

## Formatter Classloading

### With classname

In order to load the formatter class as part of the Raketask the following approach can be followed.
Basically the *require* of the formatter class needs to happen somewhere before the `RubyCritic::RakeTask` is defined.

When *rubycritic* is run, the formatter class is automatically loaded if the formatter parameter represents the fully qualified classname of the formatter class.
Taking the above example and combining it with the *Rakefile* could look as follows:

``` ruby Rakefile
...
require 'my_formatter'
RubyCritic::RakeTask.new do |task|
  ..
  task.options = %(--custom-format MyFormatter)
  ..
end
```

See the [Rakefile](https://github.com/MarcGrimme/repo-small-badge/blob/master/Rakefile#L14-L19) for [rubycritic-small-badge](https://github.com/MarcGrimme/rubycritic-small-badge/)

### With classname and classpath

When *rubycritic* is called outside of the structure that has to be **criticed** with just calling the command.
The path to load as well, as the fully qualified classname of the formatter, have to be passed.
This happens with the `--formater` option followed by the path to require (*requirepath*) a `:` as a separator and the fully qualified *classname*.
An example could look as follows:

``` shell
gem install my_formatter_gem
rubycritic --formatter my_formatter:MyFormatter
```

This will do the same as above.
