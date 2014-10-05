require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"

Rake::TestTask.new do |task|
  task.libs.push "lib"
  task.libs.push "test"
  task.pattern = "test/**/*_test.rb"
end

RuboCop::RakeTask.new

task :default => [:test, :rubocop]
