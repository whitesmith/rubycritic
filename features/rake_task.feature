Feature: RubyCritic can be run via Rake task
  In order to allow for a better CI usage
  As a developer
  I want to use RubyCritic as a Rake task

  Scenario: ‘paths' attribute is respected
    Given the smelly file 'smelly.rb'
    When I run rake rubycritic with:
      """
      RubyCritic::RakeTask.new do |t|
        t.paths = FileList['smelly.*']
        t.options = '--no-browser -f console'
      end
      """
    Then the output should contain:
      """
      (HighComplexity) AllTheMethods#method_missing has a flog score of 27
      """
    And the exit status indicates a success

  Scenario: 'name' option changes the task name
    Given the smelly file 'smelly.rb'
    When I run rake silky with:
      """
      RubyCritic::RakeTask.new('silky') do |t|
        t.paths = FileList['smelly.*']
        t.verbose = true
        t.options = '--no-browser'
      end
      """
    Then the output should contain:
      """
      Running `silky` rake command
      """

  Scenario: 'verbose' prints details about the execution
    Given the smelly file 'smelly.rb'
    When I run rake rubycritic with:
      """
      RubyCritic::RakeTask.new do |t|
        t.paths = FileList['smelly.*']
        t.verbose = true
        t.options = '--no-browser'
      end
      """
    Then the output should contain:
      """
      !!! Running `rubycritic` rake command
      !!! Inspecting smelly.rb with options --no-browser
      """

  Scenario: respect --minimum-score
    Given the smelly file 'smelly.rb'
    When I run rake rubycritic with:
      """
      RubyCritic::RakeTask.new do |t|
        t.paths = FileList['smelly.*']
        t.verbose = true
        t.options = '--no-browser -f console --minimum-score 95'
      end
      """
    Then the output should contain:
      """
      Score (93.19) is below the minimum 95
      """
