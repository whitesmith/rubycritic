# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/configuration'

describe RubyCritic::Configuration do
  describe '#root' do
    before do
      RubyCritic::Config.set
      @default = RubyCritic::Config.root
    end

    it 'has a default' do
      _(RubyCritic::Config.root).must_be_instance_of String
    end

    it 'can be set to a relative path' do
      RubyCritic::Config.root = 'foo'

      _(RubyCritic::Config.root).must_equal File.expand_path('foo')
    end

    it 'can be set to an absolute path' do
      RubyCritic::Config.root = '/foo'

      _(RubyCritic::Config.root).must_equal '/foo'
    end

    after do
      RubyCritic::Config.root = @default
    end
  end

  describe '#formats' do
    before do
      RubyCritic::Config.set(formats: [])
    end

    it 'sets html format by default' do
      _(RubyCritic::Config.formats).must_equal [:html]
    end
  end

  describe '#setup_paths_for_targets' do
    let(:config) { RubyCritic::Configuration.new }

    it 'processes paths without wildcards correctly' do
      options = { paths: ['lib', 'app/models'] }
      config.setup_paths_for_targets(options)

      _(options[:paths]).must_equal ['lib', 'app/models']
    end

    it 'expands wildcard patterns to matching directories' do
      # Create temporary directory structure for testing
      Dir.mktmpdir do |tmpdir|
        Dir.chdir(tmpdir) do
          FileUtils.mkdir_p('src/controllers')
          FileUtils.mkdir_p('src/admin/app')
          FileUtils.mkdir_p('src/admin/lib')
          FileUtils.mkdir_p('src/customer/app')
          FileUtils.mkdir_p('src/models')
          FileUtils.mkdir_p('src/views')
          FileUtils.mkdir_p('lib/tasks')

          options = { paths: ['src/**/app'] }
          config.setup_paths_for_targets(options)
          expected = ['src/admin/app', 'src/customer/app']

          _(options[:paths].sort).must_equal expected.sort
        end
      end
    end

    it 'excludes tmp directories from wildcard expansion' do
      # Create temporary directory structure for testing
      Dir.mktmpdir do |tmpdir|
        Dir.chdir(tmpdir) do
          FileUtils.mkdir_p('src/models')
          FileUtils.mkdir_p('app/models')
          FileUtils.mkdir_p('tmp/cache')
          FileUtils.mkdir_p('tmp/logs')

          options = { paths: ['**'] }
          config.setup_paths_for_targets(options)

          _(options[:paths]).wont_include 'tmp/cache'
          _(options[:paths]).wont_include 'tmp/logs'
          _(options[:paths]).wont_include 'tmp'
          _(options[:paths]).must_include 'src'
          _(options[:paths]).must_include 'app'
        end
      end
    end

    it 'handles mixed wildcard and non-wildcard paths' do
      # Create temporary directory structure for testing
      Dir.mktmpdir do |tmpdir|
        Dir.chdir(tmpdir) do
          FileUtils.mkdir_p('app/models')
          FileUtils.mkdir_p('app/controllers')
          FileUtils.mkdir_p('lib/tasks')
          FileUtils.mkdir_p('spec/support')

          options = { paths: ['app/**', 'lib', 'spec/support'] }
          config.setup_paths_for_targets(options)

          _(options[:paths]).must_include 'app/models'
          _(options[:paths]).must_include 'app/controllers'
          _(options[:paths]).must_include 'lib'
          _(options[:paths]).must_include 'spec/support'
        end
      end
    end

    it 'processes empty wildcard results correctly' do
      # Create temporary directory structure for testing
      Dir.mktmpdir do |tmpdir|
        Dir.chdir(tmpdir) do
          options = { paths: ['nonexistent/**'] }
          config.setup_paths_for_targets(options)

          _(options[:paths]).must_equal []
        end
      end
    end
  end
end
