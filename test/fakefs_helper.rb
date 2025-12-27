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

# Patch FakeFS::Pathname to include the path method for Ruby 4.0.0 compatibility
# This is needed because Reek's configuration internally calls Pathname#== which
# requires the path method to be present
module FakeFS
  class Pathname
    def path
      to_s
    end
  end
end
