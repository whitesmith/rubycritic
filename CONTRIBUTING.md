Contributing
============

RubyCritic is open source and contributions from the community are encouraged! No contribution is too small. Please consider:

* [Writing some Code](#writing-some-code)
* [Improving the Documentation](#improving-the-documentation)
* [Reporting a Bug](#reporting-a-bug)

Writing some Code
-----------------

If you want to squash a bug or add a new feature, follow these guidelines:

1. Fork the project.

2. Create a feature branch (`git checkout -b my-new-feature`).

3. Make your changes. Include tests for your changes, otherwise I may accidentally break them in the future.

4. Run the tests with the `rake` command. Make sure that they are still passing.

5. Stage partial-file changesets (`git -p`).

6. Commit your changes (`git commit`).
Make exactly as many commits as you need.
Each commit should do one thing and one thing only. For example, all whitespace fixes should be relegated to a single commit.

7. Write descriptive commit messages, in accordance with [these guidelines][1].

8. [Hide the sausage making][3]. Squash, split and reorder commits if necessary (`git rebase -i`).
For a more in-depth look at interactive rebasing, be sure to check [how to rewrite history][4].

9. Push to the branch to GitHub (`git push origin my-new-feature`).

10. Create a new [Pull Request][5] and send it to be merged with the master branch.

Improving the Documentation
---------------------------

You are encouraged to clarify how something works or to simply fix a typo. Please include `[ci skip]` on a new line in your commit message. This will signal [Travis][2] that running the test suite is not necessary for these changes.

Reporting a Bug
---------------

If you are experiencing unexpected behavior and, after having read Rubycritic's documentation, are convinced this behavior is a bug, please:

1. Search the [issues tracker][6] to see if it was already reported / fixed.

2. Include the Ruby and RubyCritic versions in your report. Here's a little table to help you out:

  ```
  |            | Version |
  |------------|---------|
  | Ruby       | 2.1.2   |
  | RubyCritic | 1.0.0   |
  ```

  The more information you provide, the easier it will be to track down the issue and fix it.

3. Create a new issue.

[1]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[2]: https://travis-ci.org
[3]: http://sethrobertson.github.io/GitBestPractices/#sausage
[4]: http://git-scm.com/book/en/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages
[5]: https://help.github.com/articles/creating-a-pull-request
[6]: https://github.com/whitesmith/rubycritic/issues
