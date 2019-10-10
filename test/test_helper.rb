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

def context(*args, &block)
  describe(*args, &block)
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
    begin
      FakeFS::FileSystem.clone(PathHelper.project_path)

      # reek schema is required to init reek
      FakeFS::FileSystem.clone(PathHelper.reek_schema_path)

      Dir.chdir(PathHelper.project_path)
      yield
    ensure
      FakeFS::FileSystem.clear
    end
  end
end

# This class is to encapsulate avoid specs class called those paths methods accidentally
module PathHelper
  class << self
    def reek_schema_path
      reek_path = Gem.loaded_specs['reek'].full_gem_path
      reek_path + '/lib/reek/configuration/schema.yml'
    end

    def project_path
      File.expand_path('..', __dir__)
    end
  end
end

module MiniTest
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
      assert diffs.empty?, "There are diffs between expected and actual values:\n#{diffs.map(&:inspect).join("\n")}"
    end
  end

  module Expectations
    ##
    # See MiniTest::Assertions#assert_matched_arrays
    #
    #     [1,2,3].must_match_array [3,2,1]
    #
    # :method: must_match_array

    infect_an_assertion :assert_matched_arrays, :must_match_array
  end
end
