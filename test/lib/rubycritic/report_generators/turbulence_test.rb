require "test_helper"
require "rubycritic/generators/html/turbulence"

describe Rubycritic::Turbulence do
  describe "::data" do
    it "returns json data that maps pathname, churn and complexity to name, x and y" do
      files = [AnalysedModuleDouble.new(:name => "Foo", :churn => 1, :complexity => 2)]
      turbulence_data = Rubycritic::Turbulence.data(files)
      instance_parsed_json = JSON.parse(turbulence_data).first
      instance_parsed_json["name"].must_equal "Foo"
      instance_parsed_json["x"].must_equal 1
      instance_parsed_json["y"].must_equal 2
    end
  end
end

class AnalysedModuleDouble < OpenStruct; end
