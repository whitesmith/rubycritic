require "bundler/gem_tasks"
require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.libs.push "test"
  t.pattern = "test/**/*_test.rb"
end
