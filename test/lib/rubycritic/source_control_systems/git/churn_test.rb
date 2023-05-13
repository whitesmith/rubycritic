# frozen_string_literal: true

require 'test_helper'

describe RubyCritic::SourceControlSystem::Git::Churn do
  let(:churn) { RubyCritic::SourceControlSystem::Git::Churn.new }

  before do
    RubyCritic::SourceControlSystem::Git.stubs(:git).returns(git_log)
  end

  let(:git_log) do
    <<~GIT_LOG
      date:\t2020-06-29 03:03:03 -0500
      C051\tROADMAP.md\tROADMAP.extend.md

      date:\t2020-01-31 08:01:07 -0500
      M\tCHANGELOG.md
      M\trubycritic.gemspec

      date:\t2020-01-27 19:42:04 +0000
      M\tCHANGELOG.md
      M\tlib/rubycritic/version.rb

      date:\t2020-01-22 09:51:16 +0000
      M\tCHANGELOG.md
      M\trubycritic.gemspec

      date:\t2019-12-30 10:46:58 +0000
      M\tCHANGELOG.md
      M\tlib/rubycritic/version.rb

      date:\t2019-12-30 19:11:09 +0900
      M\tCHANGELOG.md
      M\tlib/rubycritic/source_control_systems/git.rb
      M\ttest/lib/rubycritic/commands/compare_test.rb
      M\ttest/lib/rubycritic/source_control_systems/git_test.rb

      date:\t2014-03-19 18:17:28 +0000
      M\tlib/rubycritic/report_generators/base_generator.rb
      A\tlib/rubycritic/report_generators/index_generator.rb
      M\tlib/rubycritic/report_generators/reporter.rb
      A\tlib/rubycritic/report_generators/templates/index.html.erb
      M\tlib/rubycritic/report_generators/templates/layouts/application.html.erb

      date:\t2014-03-19 18:07:59 +0000
      M\tlib/rubycritic.rb
      A\tlib/rubycritic/report_generators/base_generator.rb
      M\tlib/rubycritic/report_generators/file_generator.rb
      M\tlib/rubycritic/report_generators/line_generator.rb
      R081\tlib/rubycritic/report_generators/report_generator.rb\tlib/rubycritic/report_generators/reporter.rb

      date:\t2014-03-19 17:23:21 +0000
      M\tlib/rubycritic/report_generators/file_generator.rb
      M\tlib/rubycritic/report_generators/line_generator.rb
      M\tlib/rubycritic/report_generators/report_generator.rb

      date:\t2014-03-18 23:02:01 +0000
      M\tlib/rubycritic.rb
      M\tlib/rubycritic/cli.rb
      A\tlib/rubycritic/report_generators/assets/stylesheets/application.css
      A\tlib/rubycritic/report_generators/file_generator.rb
      A\tlib/rubycritic/report_generators/line_generator.rb
      A\tlib/rubycritic/report_generators/report_generator.rb
      A\tlib/rubycritic/report_generators/templates/file.html.erb
      A\tlib/rubycritic/report_generators/templates/layouts/application.html.erb
      A\tlib/rubycritic/report_generators/templates/line.html.erb
      A\tlib/rubycritic/report_generators/templates/smelly_line.html.erb
    GIT_LOG
  end

  describe '#revisions_count' do
    it "counts the commits of a file that doesn't change name" do
      _(churn.revisions_count('CHANGELOG.md')).must_equal 5
    end

    it 'counts the commits including the old name of a renamed file' do
      _(churn.revisions_count('lib/rubycritic/report_generators/reporter.rb'))
        .must_equal 4
    end

    it 'returns 0 for an uncommited file' do
      _(churn.revisions_count('non_existent_file')).must_equal 0
    end

    context 'with churn_after option specified' do
      let(:churn) { RubyCritic::SourceControlSystem::Git::Churn.new(churn_after: '2015-01-01') }
      let(:log_command) do
        "log --all --date=iso --follow --format='format:date:%x09%ad' --name-status --after='2015-01-01' ."
      end

      let(:git_log) do
        <<~GIT_LOG
          date:\t2020-09-04 05:24:07 -0300
          M\tCHANGELOG.md

          date:\t2020-09-03 20:30:50 -0400
          M\tlib/rubycritic/version.rb
        GIT_LOG
      end

      it 'uses the option in the git command' do
        RubyCritic::SourceControlSystem::Git.expects(:git).with(log_command).once.returns(git_log)

        churn.revisions_count('CHANGELOG.md')
      end

      it 'returns only 1 revision' do
        _(churn.revisions_count('CHANGELOG.md')).must_equal 1
      end
    end

    context 'with paths option specified' do
      let(:analysis_targets) { ['lib/rubycritic/commands', 'lib/rubycritic/generators'] }
      let(:churn) { RubyCritic::SourceControlSystem::Git::Churn.new(paths: analysis_targets) }

      it 'executes the git log command once for each specified path' do
        RubyCritic::SourceControlSystem::Git.expects(:git).with(
          "log --all --date=iso --follow --format='format:date:%x09%ad' --name-status lib/rubycritic/commands"
        ).once.returns('')

        RubyCritic::SourceControlSystem::Git.expects(:git).with(
          "log --all --date=iso --follow --format='format:date:%x09%ad' --name-status lib/rubycritic/generators"
        ).once.returns('')

        churn.revisions_count('CHANGELOG.md')
      end
    end
  end

  describe '#date_of_last_commit' do
    it 'returns the last commit containing the file' do
      _(churn.date_of_last_commit('lib/rubycritic/report_generators/reporter.rb'))
        .must_equal '2014-03-19 18:17:28 +0000'
    end

    it 'returns nil for an uncommited file' do
      assert_nil(churn.date_of_last_commit('non_existent_file'))
    end
  end
end
