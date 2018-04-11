# Making Jenkins review Pull Requests

## Installing Jenkins and setting up RubyCritic

There is a step-by-step tutorial on how to set up Jenkins in [`building-own-code-climate.md`](./building-own-code-climate.md).

### Installing required plugins

Installing a Jenkins Plugin is extremely easy. All you have to do is proceed to `Manage Jenkins`, go to `Manage Plugins`, select the `Available` tab and then check the desired plugin.

For creating comments on PRs we are going to use the [Violation Comments to GitHub Jenkins Plugin](https://github.com/jenkinsci/violation-comments-to-github-plugin).

## Configuring the project

The Violation plugin has parsers for many different formats, and the GoLint one is compatible with the `lint` format created by RubyCritic.
We're assuming that you use a `Jenkinsfile` for creating a pipeline, but the approach can be adapted to other scenarios.


```groovy
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        // Install gems etc.
      }
    }
    stage('Test') {
      steps {
        parallel tests: { // We are running tests and code_checks in parallel to shorten build times
          sh 'bundle exec rspec'
        },
        code_checks: {
          sh 'bundle exec rubycritic -f lint'
        }
      }
    }
    stage('Package / Deploy') {
      steps {
        parallel deploy: {
          // Create Docker image / deploy via Capistrano / ...
        },
        publish_code_review: {
          step([
            $class: 'ViolationsToGitHubRecorder',
            config: [
              repositoryName: 'your_project_name',
              pullRequestId: env.CHANGE_ID, // The CHANGE_ID env variable will be set to the PR ID by Jenkins
              createSingleFileComments: true, // Create one comment per violation
              commentOnlyChangedContent: true, // Only comment on lines that have changed
              keepOldComments: false,
              violationConfigs: [
                [ pattern: '.*/lint\\.txt$', parser: 'GOLINT', reporter: 'RubyCritic' ], // RubyCritic will output a lint.txt file in GoLint compatible format
              ]
            ]])
        }
      }
    }
  }
}
```

For further information, check out the documentation of the [Violation Comments to GitHub Jenkins Plugin](https://github.com/jenkinsci/violation-comments-to-github-plugin).
