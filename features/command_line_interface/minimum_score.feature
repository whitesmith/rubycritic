Feature: Break if overall score is below minimum
  In order to break the Continuous Integration builds based on a score threshold
  RubyCritic returns the exit status according with the score

  Scenario: Status indicates a success when not using --minimum-score
    Given the smelly file 'smelly.rb' with a score of 93.19
    When I run rubycritic smelly.rb
    Then the exit status indicates a success

  Scenario: Status indicates an error when score below the minimum
    Given the smelly file 'smelly.rb' with a score of 93.19
    When I run rubycritic --minimum-score 100 smelly.rb
    Then the exit status indicates an error

  Scenario: Status indicates a success when score is above the minimum
    Given the smelly file 'smelly.rb' with a score of 93.19
    When I run rubycritic --minimum-score 93 smelly.rb
    Then the exit status indicates a success

  Scenario: Status indicates a success when score is equal the minimum
    Given the clean file 'clean.rb' with a score of 100
    When I run rubycritic --minimum-score 100 clean.rb
    Then the exit status indicates a success

  Scenario: Prints the score on output
    Given the smelly file 'smelly.rb' with a score of 93.19
    When I run rubycritic smelly.rb
    Then the output should contain:
    """
    Score: 93.19
    """

  Scenario: Prints a message informing the score is below the minimum
    Given the empty file 'empty.rb' with a score of 0
    When I run rubycritic --minimum-score 100 empty.rb
    Then the output should contain:
    """
    Score (0.0) is below the minimum 100
    """
