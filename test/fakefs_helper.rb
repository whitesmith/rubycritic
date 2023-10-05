# frozen_string_literal: true

require 'etc'
require 'fakefs/safe'

module FakeFS
  class File < StringIO
    # $VERBOSE = nil to suppress warnings when we overrie flock.
    original_verbose = $VERBOSE
    $VERBOSE = nil
    def flock(*)
      true
    end
    $VERBOSE = original_verbose
  end
end

module FakeFSPatch
  def home(user = Etc.getlogin)
    RealDir.home(user)
  end
end
FakeFS::Dir.singleton_class.prepend(FakeFSPatch)
