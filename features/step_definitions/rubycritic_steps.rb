# frozen_string_literal: true

When(/^I run rubycritic (.*)$/) do |args|
  rubycritic(args)
end

Then(/^the exit status indicates an error$/) do
  expect(last_command_started).to have_exit_status(RubyCritic::Command::StatusReporter::SCORE_BELOW_MINIMUM)
end

Then(/^the exit status indicates a success$/) do
  expect(last_command_started).to have_exit_status(RubyCritic::Command::StatusReporter::SUCCESS)
end

Then(/^it reports:$/) do |report|
  expect(last_command_started).to have_output_on_stdout(report.gsub('\n', "\n"))
end

Then(/^there is no output on stdout$/) do
  expect(last_command_started).to have_output_on_stdout('')
end

Then(/^it reports the current version$/) do
  expect(last_command_started).to have_output("RubyCritic #{RubyCritic::VERSION}\n")
end

Then(/^it reports the error ['"](.*)['"]$/) do |string|
  expect(last_command_started).to have_output_on_stderr(/#{Regexp.escape(string)}/)
end

Then(/^it succeeds$/) do
  expect(last_command_started).to have_exit_status(RubyCritic::Command::StatusReporter::SUCCESS)
end
