require "analysers_test_helper"
require "rubycritic/analysers/churn"
require "rubycritic/source_control_systems/base"

describe Rubycritic::Analyser::Churn do
  before do
    @analysed_files = [AnalysedFileDouble.new(:path => "path_to_some_file.rb")]
    @source_control_system = SourceControlSystemDouble.new
  end

  it "calculates the churn of each file and adds it to analysed_files" do
    Rubycritic::Analyser::Churn.new(@analysed_files, @source_control_system).run
    @analysed_files.each do |analysed_file|
      analysed_file.churn.must_equal 1
    end
  end

  it "calculates the date of the last commit of each file and adds it to analysed_files" do
    Rubycritic::Analyser::Churn.new(@analysed_files, @source_control_system).run
    @analysed_files.each do |analysed_file|
      analysed_file.committed_at.must_equal "2013-10-09 12:52:49 +0100"
    end
  end
end

class SourceControlSystemDouble < Rubycritic::SourceControlSystem::Base
  def revisions_count(path)
    1 # churn
  end

  def date_of_last_commit(path)
    "2013-10-09 12:52:49 +0100"
  end
end
