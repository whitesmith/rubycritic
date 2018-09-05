# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/commands/compare'
require 'rubycritic/cli/options'
require 'rubycritic/configuration'
require 'rubycritic/source_control_systems/git'

module RubyCritic
  module SourceControlSystem
    class Git < Base
      def self.current_branch
        'feature_branch'
      end
    end
  end

  module Command
    class Compare
      def abort(str); end
    end
  end
end

describe RubyCritic::Command::Compare do
  before do
    RubyCritic::Browser.any_instance.stubs(:open).returns(nil)
    RubyCritic::Reporter.stubs(:generate_report).returns(nil)
    RubyCritic::Command::Compare.any_instance.stubs(:build_details).returns(nil)
    RubyCritic::SourceControlSystem::Git.stubs(:modified_files).returns('test/samples/compare_file.rb')
  end

  describe 'comparing the same file for two different branches' do
    after do
      # clear file contents after tests
      File.open('test/samples/compare_file.rb', 'w') { |file| file.truncate(0) }
    end

    context 'when file from feature_branch has a worse score than base_branch' do
      before do
        RubyCritic::SourceControlSystem::Git.class_eval do
          def self.switch_branch(branch)
            FileUtils.cp "test/samples/#{branch}_file.rb", 'test/samples/compare_file.rb'
          end
        end
      end

      it 'errors by aborting the process' do
        options = ['-b', 'base_branch', '-t', '0', 'test/samples/compare_file.rb']
        options = RubyCritic::Cli::Options.new(options).parse.to_h
        RubyCritic::Config.set(options)

        comparison = RubyCritic::Command::Compare.new(options)
        comparison.expects(:abort).once

        status_reporter = comparison.execute
        status_reporter.score.must_equal RubyCritic::Config.feature_branch_score
        status_reporter.score.wont_equal RubyCritic::Config.base_branch_score
        status_reporter.status_message.must_equal "Score: #{RubyCritic::Config.feature_branch_score}"
      end
    end

    context 'when file from feature_branch has an equal or better score than base_branch' do
      before do
        RubyCritic::SourceControlSystem::Git.class_eval do
          def self.switch_branch(_branch)
            FileUtils.cp 'test/samples/base_branch_file.rb', 'test/samples/compare_file.rb'
          end
        end
      end
      it 'outputs score' do
        options = ['-b', 'feature_branch', '-t', '0', 'test/samples/compare_file.rb']
        options = RubyCritic::Cli::Options.new(options).parse.to_h
        RubyCritic::Config.set(options)
        status_reporter = RubyCritic::Command::Compare.new(options).execute
        status_reporter.score.must_equal RubyCritic::Config.feature_branch_score
        status_reporter.score.must_equal RubyCritic::Config.base_branch_score
        status_reporter.status_message.must_equal "Score: #{RubyCritic::Config.feature_branch_score}"
      end
    end
  end

  describe 'with default options passing two branches' do
    before do
      options = ['-b', 'base_branch', '-t', '10', 'test/samples/compare_file.rb']
      @options = RubyCritic::Cli::Options.new(options).parse.to_h
    end

    it 'with -b option withour pull request id' do
      @options[:base_branch].must_equal 'base_branch'
      @options[:feature_branch].must_equal 'feature_branch'
      @options[:mode].must_equal :compare_branches
      @options[:threshold_score].must_equal 10
    end
  end
end
