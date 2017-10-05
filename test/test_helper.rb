# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/around/spec'
require 'minitest/pride'
require 'mocha/mini_test'
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
      config = File.expand_path('..', __dir__)
      FakeFS::FileSystem.clone(config)
      Dir.chdir(config)
      yield
    ensure
      FakeFS::FileSystem.clear
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
