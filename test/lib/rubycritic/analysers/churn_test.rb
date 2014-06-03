require "test_helper"
require "rubycritic/analysers/churn"
require "rubycritic/source_control_systems/base"

describe Rubycritic::Analyser::Churn do
  before do
    @analysed_files = [AnalysedFileDouble.new(:path => "path_to_some_file.rb")]
    @source_control_system = SourceControlSystemDouble.new
  end

  describe "#churn" do
    it "calculates the churn of each file and adds it to analysed_files" do
      Rubycritic::Analyser::Churn.new(@analysed_files, @source_control_system).churn
      @analysed_files.each do |analysed_file|
        analysed_file.churn.must_equal 1
      end
    end
  end
end

class AnalysedFileDouble < OpenStruct; end

class SourceControlSystemDouble < Rubycritic::SourceControlSystem::Base
  def revisions_count(file)
    1 # churn
  end
end
