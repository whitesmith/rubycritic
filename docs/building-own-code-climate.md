# Building your own Code Climate

## Installing Jenkins

There are [official guides for installing Jenkins][1] on pretty much any platform. After following the most suitable one, Jenkins should be running on the Build Server (your machine or AWS, for example).

From this point forward, everything should be installed under the Jenkins user account on the Build Server. Switching user accounts can be achieved by running the Switch User command:

```bash
$ sudo su - jenkins
```

In the likely event that you don't know your Jenkins user's password, run the following command to change it:

```bash
$ sudo passwd jenkins
```

## Installing Ruby

There are many different [ways to install Ruby][2], RVM and rbenv being the two most popular ones. RVM has a nice [guide on using RVM with Jenkins][3]. Regardless of what you choose, you should now have Ruby running on the Build Server and be able to install any gems.

Ensure that everything is working correctly by running the following command:

```bash
$ ruby --version
```

## Installing gems

You should install two gems after installing Ruby: Bundler and RubyCritic. You can do so with the following command:

```bash
$ gem install bundler rubycritic
```

## Installing Git

Next up, Git should be installed since Jenkins needs it to be able to clone your repositories in order to analyse them. [This is the installation guide recommended][4] to install Git.

Ensure that everything is working correctly by running the following command:

```bash
$ git --version
```

## Generating SSH Keys

SSH keys are a way to identify trusted computers without involving passwords. GitHub has an excellent guide on [generating SSH keys][5] which you should definitely follow.

However, you may want to create a GitHub account just for your Jenkins user. The alternative requires you to add the new SSH Key to your account which, from a security standpoint, is probably a bad idea.

Ensure that everything is working correctly by running the following command:

```bash
$ ssh -T git@github.com
```

## Configuring Jenkins

Jenkins should be running automatically after being installed. The Jenkins UI should be accessible at `http://localhost:8080/` in your browser. The next few steps all take place in that UI.

### Enabling Security

By default Jenkins is not secure which means anyone is able to run commands on the Build Server and access your private projects. There are many [ways to secure Jenkins][6], but the simplest one is standard authentication with a username and password.

From the main page, head to `Manage Jenkins` and then to `Configure Global Security` where the option `Enable security` should be checked. Still on the same page, select `Jenkins' own user database` under `Security Realm` and leave `Allow users to sign up` enabled for now.

After configuring these options, a new `sign up` link should appear in the top right corner of every page. After signing up and returning to the `Configure Global Security` page where you were before, it's time to set up some restrictions. The easiest way to do so is to select the option `Logged-in users can do anything` instead of the usual `Anyone can do anything` under `Authorization` and then deselect the option `Allow users to sign up`.

Ensure that everything is working correctly by logging out and logging in again. If you have any problems after these steps and can no longer access Jenkins, you can [reset its security settings][7] and try again.

### Installing Plugins

Installing a Jenkins Plugin is extremely easy. All you have to do is proceed to `Manage Jenkins`, go to `Manage Plugins`, select the `Available` tab and then check the desired plugin.

To build your own Code Climate, three plugins are needed:

  * [GitHub][8], which triggers jobs when you push to a GitHub repository.

  * [Git][9], which allows cloning Git repositories.

  * [HTML Publisher][10], which persists RubyCritic's reports and creates a web interface to access them.

However, you can install many other plugins that will improve your Build server, like:

  * [Jenkins ci skip][11], which skips a build when `[ci skip]` is added to a commit's message.

## Creating Your First Job

Finally, it's time to set up the job that will run in the Build Server after every push. Head to the main page and then to `New Item`. Give the job a name (like the name of your project) and select the option `Build a free-style software project`. Clicking the `OK` button will create the job and take you to the configuration page for that job.

Under `Source Code Management` select `Git` and enter your project's repository URL. If your project is private, then you need to set up Jenkins' credentials so that GitHub can authorize it. This was the reason for setting up Jenkins' SSH key beforehand. Now all that has to be done is to click the `Add` button on the far right, pick the `kind` of credentials `SSH Username with private key` and select the `Private key` option `from the Jenkins master ~/.ssh`. Confirm these new credentials by clicking another `Add` button.

Under `Branches to build` you can enter one or more branches that you want Jenkins to build against. The default is `*/master` but you can leave the `branch` field blank so that Jenkins builds against any changed branch.

Under `Build Triggers` select `Build when a change is pushed to GitHub`, and start configuring the `Build` script. Click the dropdown `Add build step`, select the `Execute shell` option and in the new textarea enter the script to be run after every push. The possibilities here are endless. You could:

  * Build a Continuous Integration server like Travis. To do so, the script could consist in just the following commands:

  ```bash
  bundle
  rake
  ```

  These commands would install all the gems defined in your project's Gemfile and run the project's tests.

  If you had installed Ruby through RVM, your project was a gem and you wished to test it using different, stable Ruby versions, you might change the script to something like this:

  ```bash
  #!/bin/bash
  rvm use 1.9.3
  bundle
  rake
  rvm use 2.1
  bundle
  rake
  ```

  Please note that the first line specifies bash as the shell that runs the script and is **necessary** for the script to successfully run.

  * Build a service like Code Climate using the RubyCritic gem. In that case, the script could consist in just the following command:

  ```bash
  rubycritic app lib
  ```

  However, Jenkins isolates and cleans the workspace after every build thus making it necessary to use the HTML Publisher plugin (previously installed) to persist the reports generated by RubyCritic.

  Under `Post-build Actions` select `Publish HTML reports`, enter `tmp/rubycritic/` as the `HTML directory to archive`, `overview.html` as the `Index page` and give a title to the report. If you select the option `Keep past HTML reports`, you'll be able to access previous RubyCritic reports, giving you more insight into where your project has been and where it is heading.

Finally, click the `Save` button to save your job configuration. You can try out your build right away by clicking the `Build Now` button.

### Failing fast: the `--minimum-score` option

The CLI option `--minimum-score` makes `rubycritic` return the exit status according to the calculated score: it returns an error exit status if the score is below the set minimum. A helpful message is also printed. This allows your CI job to fail on too-low scores.

## Setting Up A GitHub Service

The last step is to set up GitHub integration so that a push triggers a new job in the Build Server. You’ll need admin access to your project's repository to be able to change its settings. On the repository page navigate to `Settings`, `Webhooks & Services` and click the `Add service` button. Select the `Jenkins (GitHub plugin)` options and set the `Jenkins hook url`.

This URL is the same as the one you use to access the Jenkins UI followed by `/github-webhook/`. On AWS, for example, your URL could look something like `http://ec2-12-34-567-890.amazonaws.com:8080/github-webhook/`.

And you're finally done! After every push to GitHub your Build Server should run RubyCritic and present its results, very much like Code Climate!

[1]: https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins
[2]: https://www.ruby-lang.org/en/installation/
[3]: https://rvm.io/integration/jenkins
[4]: http://git-scm.com/book/en/Getting-Started-Installing-Git
[5]: https://help.github.com/articles/generating-ssh-keys
[6]: https://wiki.jenkins-ci.org/display/JENKINS/Securing+Jenkins
[7]: https://wiki.jenkins-ci.org/display/JENKINS/Disable+security
[8]: https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin
[9]: https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin
[10]: https://wiki.jenkins-ci.org/display/JENKINS/HTML+Publisher+Plugin
[11]: https://github.com/banyan/jenkins-ci-skip-plugin
