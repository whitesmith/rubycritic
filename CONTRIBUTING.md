Contributing
============

RubyCritic is open source and contributions from the community are encouraged! No contribution is too small. Please consider:

* [Writing some Code](#writing-some-code)
* [Improving the Documentation](#improving-the-documentation)
* [Reporting a Bug](#reporting-a-bug)

Writing some Code
-----------------

If you want to squash a bug or add a new feature, please:

1. Fork the project.

2. Create a feature branch (`git checkout -b my-new-feature`).

3. Make your changes. Include tests for your changes, otherwise I may accidentally break them in the future.

4. Run the tests with the `rake` command. Make sure that they are still passing.

5. Add a Changelog entry. Refer [Changelog entry format](#changelog-entry-format).

6. [Stage partial-file changesets] \(`git add -p`).

7. Commit your changes (`git commit`).
Make exactly as many commits as you need.
Each commit should do one thing and one thing only. For example, all whitespace fixes should be relegated to a single commit.

8. Write [descriptive commit messages].

9. Push the branch to GitHub (`git push origin my-new-feature`).

10. [Create a Pull Request] and send it to be merged with the master branch.

11. After your code is reviewed, [hide the sausage making]. We follow the "one commit per pull request" [principle](http://ndlib.github.io/practices/one-commit-per-pull-request/) since this allows for a clean git history, easy handling of features and convenient rollbacks when things go wrong. Or in one sentence: You can have as many commits as you want in your pull request, but after the final review and before the merge you need to squash all of those in one single commit.
For a more in-depth look at interactive rebasing, be sure to check [how to rewrite history] as well.

Improving the Documentation
---------------------------

You are welcome to clarify how something works or simply fix a typo. Please include `[ci skip]` on a new line in each of your commit messages. This will signal [Travis] that running the test suite is not necessary for these changes.

Reporting a Bug
---------------

If you are experiencing unexpected behavior and, after having read the documentation, you are convinced this behavior is a bug, please:

1. Search the [issues tracker] to see if it was already reported / fixed.

2. [Create a new issue].

3. Include the Ruby and RubyCritic versions in your report. Here's a little table to help you out:

  ```
  |            | Version |
  |------------|---------|
  | Ruby       | 2.1.2   |
  | RubyCritic | 1.0.0   |
  ```

  The more information you provide, the easier it will be to track down the issue and fix it.
  If you have never written a bug report before, or if you want to brush up on your bug reporting skills, read Simon Tatham's essay [How to Report Bugs Effectively].

[Stage partial-file changesets]: http://nuclearsquid.com/writings/git-add/
[descriptive commit messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[Create a pull request]: https://help.github.com/articles/creating-a-pull-request
[hide the sausage making]: http://sethrobertson.github.io/GitBestPractices/#sausage
[how to rewrite history]: http://git-scm.com/book/en/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages
[Travis]: https://travis-ci.org
[issues tracker]: https://github.com/whitesmith/rubycritic/issues
[Create a new issue]: https://github.com/whitesmith/rubycritic/issues/new
[How to Report Bugs Effectively]: http://www.chiark.greenend.org.uk/~sgtatham/bugs.html

Changelog entry format
------------------------

Here are a few examples:

```
* [BUGFIX] Fix errors when no source-control is found (by [@tejasbubane][])
* [BUGFIX] Fix lack of the GPA chart when used with rake/rails (by [@hoshinotsuyoshi][])
* [BUGFIX] Fix code navigation links in the new UI (by [@rohitcy][])
```

* Mark it up in [Markdown syntax](http://daringfireball.net/projects/markdown/syntax).
* Add your entry in the `master (unreleased)` section.
* The entry line should start with `* ` (an asterisk and a space).
* Start with the change type BUGFIX / CHANGE / FEATURE.
* Describe the brief of the change.
* At the end of the entry, add an implicit link to your GitHub user page as `([@username][])`.
* If this is your first contribution to RuboCop project, add a link definition for the implicit link to the bottom of the changelog as `[@username]: https://github.com/username`.
