These are more nice-to-haves than promises. We can always dream. But this is what we hope to improve in RubyCritic:

- [ ] Explain every single code smell. This includes the "Churn vs Complexity" scatter plot and other graphs that may be implemented.

- [ ] Provide suggestions to fix every code smell. Figure out how to present them in the UI.

- [ ] Improve how modules are graded. Each module is awarded a score, depending on:

  * Its complexity, based off of this [post by Jake Scruggs](http://jakescruggs.blogspot.pt/2008/08/whats-good-flog-score.html), creator of the MetricFu gem. For every 25 points of complexity (as calculated by Flog), the score increases by 1.

  * Its duplication mass, based off of observations of a few Code Climate repos. For every 25 points of mass (as calculated by Flay), the score increases by 1.

  Finally, this score is translated to a grade like [this](https://github.com/whitesmith/rubycritic/blob/43005e7b76dd0c648c7715133e42afdd6ea9a065/lib/rubycritic/core/rating.rb), based off of a [Code Climate blog post](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/#value-objects).

- [ ] Implement a project rating, ala Code Climate.

- [ ] Explain ratings. What's the difference between an A and a B? Bryan Helmkamp, the creator of Code Climate, wrote [a great essay on the subject](https://gist.github.com/brynary/21369b5892525e1bd102). #63

- [ ] Explore alternative ratings. GPA and A-F grades are quite US centric. #50

- [ ] Make the gem configurable using a dotfile like .rubycritic.yml. #30
      Here are some possible settings:

  - [ ] Quiet mode. As of right now, any Ruby code that is unparsable will be reported three times (one time by Flog, another by Flay and another by Reek). Only Flog implements a quiet option, which means we have to implement that quiet option on Flay and on Reek before we can add it to RubyCritic. Or we could just do `$stderr = StringIO.new`... I wonder if that's really really smart or really really stupid.

  - [ ] Verbose mode. #61

  - [ ] Ignoring/excluding files. #11

  - [ ] Allow configuring date range of Churn calculation. #37 Right now, they are limited to the last year. #39

- [ ] Highlight blocks of duplicated code instead of just the start of the block. This will probably require rewriting Flay with [parser](https://github.com/whitequark/parser) instead of ruby_parser.

- [ ] Integrate other gems, like:

  - [ ] [Simplecov](https://github.com/colszowka/simplecov) to provide code coverage

  - [ ] [Rubocop](https://github.com/bbatsov/rubocop/) to provide style issues

  - [ ] [Brakeman](https://github.com/presidentbeef/brakeman) to provide security issues (Rails-only feature)

  - [ ] [Rails Best Practices](https://github.com/railsbp/rails_best_practices) to provide Rails smells (Rails-only feature) #14 

  - [ ] [SandiMeter](https://github.com/makaroni4/sandi_meter) #15

- [ ] Improve UI.

  - [ ] Make it beautiful.

  - [ ] Figure out where the "suggestions to fix code smells" should be presented.

  - [ ] Create some kind of toggle option between various types of issues. Just like we can toggle between "Smells" and "Coverage" in Code Climate:

    ![Code Climate Toggle Option](https://camo.githubusercontent.com/d97fc62dae6ebef1f35bda91942d4a6bacc445b2/687474703a2f2f626c6f672e636f6465636c696d6174652e636f6d2f696d616765732f706f7374732f74657374696e672e676966)

    Having an option to toggle between "Smells", "Security" (Brakeman) and "Style" (Rubocop) would be great. But that's already assuming we can integrate those gems into RubyCritic.