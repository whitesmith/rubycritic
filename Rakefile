require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'reek/rake/task'

Rake::TestTask.new do |task|
  task.libs.push 'lib'
  task.libs.push 'test'
  task.pattern = 'test/**/*_test.rb'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format progress --color'
end

RuboCop::RakeTask.new

Reek::Rake::Task.new

task default: [:test, :features, :reek, :rubocop]
