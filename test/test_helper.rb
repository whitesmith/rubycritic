# frozen_string_literal: true

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  SimpleCov.start do
    track_files '/lib/'
  end
end

require 'minitest/autorun'
require 'minitest/around/spec'
require 'minitest/pride'
require 'mocha/minitest'
require 'ostruct'
require 'diff/lcs'

# On JRuby, Ruby 3.4's bundled_gems require shim can clobber Zeitwerk's
# implicit-namespace autoloads if a bundled gem (e.g. racc, pulled in by
# ruby_parser/flog) re-wraps Kernel#require after Zeitwerk is set up. When that
# happens, reek's deferred load of dry-schema's `Macros` namespace fails with
# "cannot load such file -- .../dry/schema/macros". Forcing reek's schema to
# load up front, before any flog/ruby_parser require, sidesteps the ordering
# issue. The application itself is unaffected because it loads reek before flog.
if defined?(JRUBY_VERSION)
  require 'reek'
  Reek::Configuration::Schema
end

def context(...)
  describe(...)
end

def capture_output_streams
  $stdout = StringIO.new
  $stderr = StringIO.new
  yield
ensure
  $stdout = STDOUT
  $stderr = STDERR
end

def with_cloned_fs
  FakeFS do
    FakeFS::FileSystem.clone(PathHelper.project_path)

    # reek schema is required to init reek
    FakeFS::FileSystem.clone(PathHelper.reek_schema_path)

    Dir.chdir(PathHelper.project_path)
    yield
  ensure
    FakeFS::FileSystem.clear
  end
end

# This class is to encapsulate avoid specs class called those paths methods accidentally
module PathHelper
  class << self
    def reek_schema_path
      "#{Gem.loaded_specs['reek'].full_gem_path}/lib/reek/configuration/schema.yml"
    end

    def project_path
      File.expand_path('..', __dir__)
    end
  end
end

module Minitest
  module Assertions
    ##
    # Fails unless <tt>exp</tt> and <tt>act</tt> are both arrays and
    # contain the same elements.
    #
    #     assert_matched_arrays [3,2,1], [1,2,3]

    def assert_matched_arrays(exp, act)
      exp_ary = exp.to_ary

      assert_kind_of Array, exp_ary
      act_ary = act.to_ary

      assert_kind_of Array, act_ary
      diffs = Diff::LCS.sdiff(act_ary.sort, exp_ary.sort).reject(&:unchanged?)

      assert_empty diffs, "There are diffs between expected and actual values:\n#{diffs.map(&:inspect).join("\n")}"
    end
  end

  module Expectations
    ##
    # See Minitest::Assertions#assert_matched_arrays
    #
    #     [1,2,3].must_match_array [3,2,1]
    #
    # :method: must_match_array

    infect_an_assertion :assert_matched_arrays, :must_match_array
  end
end
