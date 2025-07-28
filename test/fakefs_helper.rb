# frozen_string_literal: true

require 'etc'
require 'fakefs/safe'

module FakeFS
  class File < StringIO
    # $VERBOSE = nil to suppress warnings when we override flock.
    original_verbose = $VERBOSE
    $VERBOSE = nil

    # rubocop:disable Naming/PredicateMethod
    def flock(*)
      true
    end
    # rubocop:enable Naming/PredicateMethod
    $VERBOSE = original_verbose
  end
end

module FakeFSPatch
  def home(user = Etc.getlogin)
    RealDir.home(user)
  end
end
FakeFS::Dir.singleton_class.prepend(FakeFSPatch)
