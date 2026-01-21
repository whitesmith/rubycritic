# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'reek/rake/task'
require 'rubycritic/rake_task'

Rake::TestTask.new do |task|
  task.libs.push 'lib'
  task.libs.push 'test'
  task.pattern = 'test/**/*_test.rb'
end

Rake::TestTask.new(:spec) do |task|
  task.libs.push 'lib'
  task.libs.push 'test'
  task.pattern = 'test/**/*_spec.rb'
end

RuboCop::RakeTask.new

Reek::Rake::Task.new

RubyCritic::RakeTask.new do |task|
  task.paths = FileList['lib/**/*.rb']
end

task default: %i[test spec reek rubocop]
