require "analysers_test_helper"
require "rubycritic/analysers/adapters/methods_counter"

describe Rubycritic::MethodsCounter do
  describe "::count" do
    context "when a file contains Ruby code" do
      it "calculates the number of methods" do
        Rubycritic::MethodsCounter.count("test/samples/methods_count.rb").must_equal 2
      end
    end

    context "when a file is empty" do
      it "returns 0 as the number of methods" do
        Rubycritic::MethodsCounter.count("test/samples/empty.rb").must_equal 0
      end
    end

    context "when a file is unparsable" do
      it "does not blow up and returns 0 as the number of methods" do
        capture_output_streams do
          Rubycritic::MethodsCounter.count("test/samples/unparsable.rb").must_equal 0
        end
      end
    end
  end
end
