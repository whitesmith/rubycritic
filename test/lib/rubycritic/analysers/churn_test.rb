require "analysers_test_helper"
require "rubycritic/analysers/churn"
require "rubycritic/source_control_systems/base"

describe Rubycritic::Analyser::Churn do
  context "when analysing a file" do
    before do
      @analysed_module = AnalysedModuleDouble.new(:path => "path_to_some_file.rb")
      analysed_modules = [@analysed_module]
      analyser = Rubycritic::Analyser::Churn.new(analysed_modules)
      analyser.source_control_system = SourceControlSystemDouble.new
      analyser.run
    end

    it "calculates its churn" do
      @analysed_module.churn.must_equal 1
    end

    it "determines the date of its last commit" do
      @analysed_module.committed_at.must_equal "2013-10-09 12:52:49 +0100"
    end
  end
end

class SourceControlSystemDouble < Rubycritic::SourceControlSystem::Base
  def revisions_count(_path)
    1 # churn
  end

  def date_of_last_commit(_path)
    "2013-10-09 12:52:49 +0100"
  end
end
