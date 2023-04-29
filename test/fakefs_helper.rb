# frozen_string_literal: true

require 'etc'
require 'fakefs/safe'

module FakeFS
  class File < StringIO
    def flock(*)
      true
    end
  end
end

module FakeFSPatch
  def home(user = Etc.getlogin)
    RealDir.home(user)
  end
end
::FakeFS::Dir.singleton_class.prepend(FakeFSPatch)
