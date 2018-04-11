# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/source_control_systems/base'

describe RubyCritic::SourceControlSystem::Perforce do
  before do
    @system = RubyCritic::SourceControlSystem::Perforce.new
  end

  describe RubyCritic::SourceControlSystem::Perforce do
    describe '::supported?' do
      let(:path) do
        ['/some/path', File::PATH_SEPARATOR, '/perforce/path/p4', File::PATH_SEPARATOR + '/other/useless_path'].join
      end
      let(:p4_client) { 'UNIT_TEST_CLIENT' }

      context 'directory is under p4 client' do
        it 'detects if Perforce is the source control used' do
          ENV['PATH'] = path
          ENV['P4CLIENT'] = p4_client
          Gem.stubs(:win_platform?).returns(false)
          File.stubs(:executable?).with('/some/path/p4').returns(false)
          File.stubs(:executable?).with('/perforce/path/p4/p4').returns(true)
          RubyCritic::SourceControlSystem::Perforce.stubs(:in_client_directory?).returns(true)

          RubyCritic::SourceControlSystem::Perforce.supported?.must_equal true
        end
      end

      context 'directory is not under p4 client' do
        it 'returns false if no p4 executables are found' do
          ENV['PATH'] = path
          ENV['P4CLIENT'] = nil
          Gem.stubs(:win_platform?).returns(false)
          File.stubs(:executable?).with('/some/path/p4').returns(false)
          File.stubs(:executable?).with('/perforce/path/p4/p4').returns(false)
          File.stubs(:executable?).with('/other/useless_path/p4').returns(false)

          RubyCritic::SourceControlSystem::Perforce.supported?.must_equal false
        end

        it 'returns false if no p4 client is set in environment variables' do
          ENV['PATH'] = path
          ENV['P4CLIENT'] = nil
          Gem.stubs(:win_platform?).returns(false)
          File.stubs(:executable?).with('/some/path/p4').returns(false)
          File.stubs(:executable?).with('/perforce/path/p4/p4').returns(true)

          RubyCritic::SourceControlSystem::Perforce.supported?.must_equal false
        end

        it 'returns false if the current directory is not under p4 client' do
          ENV['PATH'] = path
          ENV['P4CLIENT'] = p4_client
          Gem.stubs(:win_platform?).returns(false)
          File.stubs(:executable?).with('/some/path/p4').returns(false)
          File.stubs(:executable?).with('/perforce/path/p4/p4').returns(true)
          RubyCritic::SourceControlSystem::Perforce.stubs(:in_client_directory?).returns(false)

          RubyCritic::SourceControlSystem::Perforce.supported?.must_equal false
        end
      end
    end

    describe '::in_client_directory?' do
      context 'current directory is in p4 client' do
        let(:p4_info) do
          <<-P4INFO
User name: unit_test_user
Client name: UNIT_TEST_CLIENT
Client host: MACHINE_NAME
Client root: /path/to/client/root
Current directory: /path/to/client/root/ruby_project/unit_test
Peer address: 127.0.0.1::3000
Client address: 127.0.0.1
Server address: the.server.address.com
          P4INFO
        end

        it 'calls p4 info and parse the result' do
          RubyCritic::SourceControlSystem::Perforce.stubs(:`).with('p4 info').returns(p4_info)
          RubyCritic::SourceControlSystem::Perforce.in_client_directory?.must_equal true
        end
      end

      context 'current directory is not in p4 client' do
        let(:p4_info) do
          <<-P4INFO
User name: unit_test_user
Client name: UNIT_TEST_CLIENT
Client host: MACHINE_NAME
Client root: /path/to/client/root
Current directory: /somewhere/else/ruby_project/unit_test
Peer address: 127.0.0.1::3000
Client address: 127.0.0.1
Server address: the.server.address.com
          P4INFO
        end

        it 'calls p4 info and parse the result' do
          RubyCritic::SourceControlSystem::Perforce.stubs(:`).with('p4 info').returns(p4_info)
          RubyCritic::SourceControlSystem::Perforce.in_client_directory?.must_equal false
        end
      end
    end

    describe 'retrieve informations' do
      let(:p4_stats) do
        <<-P4STATS
... clientFile /path/to/client/a_ruby_file.rb
... headTime 1473075551
... headRev 16
... headChange 2103503

... clientFile /path/to/client/second_ruby_file.rb
... headTime 1464601668
... action opened
... headRev 12
... headChange 2103504
        P4STATS
      end

      describe 'build_file_cache' do
        it 'builds the perforce file cache' do
          RubyCritic::SourceControlSystem::Perforce.stubs(:`).returns(p4_stats)
          file_cache = @system.send(:perforce_files)
          file_cache.size.must_equal 2

          first_file = file_cache['/path/to/client/a_ruby_file.rb']
          first_file.filename.must_equal '/path/to/client/a_ruby_file.rb'
          first_file.revision.must_equal '16'
          first_file.last_commit.must_equal '1473075551'
          first_file.head.must_equal '2103503'
          first_file.opened?.must_equal false

          second_file = file_cache['/path/to/client/second_ruby_file.rb']
          second_file.filename.must_equal '/path/to/client/second_ruby_file.rb'
          second_file.revision.must_equal '12'
          second_file.last_commit.must_equal '1464601668'
          second_file.head.must_equal '2103504'
          second_file.opened?.must_equal true
        end
      end

      it 'retrieves the number revisions of the ruby files' do
        Dir.stubs(:getwd).returns('/path/to/client')
        RubyCritic::SourceControlSystem::Perforce.stubs(:`).once.returns(p4_stats)
        @system.revisions_count('a_ruby_file.rb').must_equal 16
        @system.revisions_count('second_ruby_file.rb').must_equal 12
      end

      it 'retrieves the date of the last commit of the ruby files' do
        oldtz = ENV['TZ']
        ENV['TZ'] = 'utc'
        Dir.stubs(:getwd).returns('/path/to/client')
        RubyCritic::SourceControlSystem::Perforce.stubs(:`).once.returns(p4_stats)
        @system.date_of_last_commit('a_ruby_file.rb').must_equal '2016-09-05 11:39:11 +0000'
        @system.date_of_last_commit('second_ruby_file.rb').must_equal '2016-05-30 09:47:48 +0000'
        ENV['TZ'] = oldtz
      end

      it 'retrieves the information if the ruby file is opened (in the changelist and ready to commit)' do
        Dir.stubs(:getwd).returns('/path/to/client')
        RubyCritic::SourceControlSystem::Perforce.stubs(:`).once.returns(p4_stats)
        @system.revision?.must_equal true
      end

      it 'retrieves the head reference of the repository' do
        Dir.stubs(:getwd).returns('/path/to/client')
        RubyCritic::SourceControlSystem::Perforce.stubs(:`).once.returns(p4_stats)
        @system.head_reference.must_equal '2103504'
      end
    end
  end
end
