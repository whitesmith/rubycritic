require "test_helper"
require "rubycritic/analysers/helpers/modules_locator"

describe Rubycritic::ModulesLocator do
  describe "::names" do
    context "when a file contains Ruby code" do
      it "returns the names of all the classes and modules inside the file" do
        Rubycritic::ModulesLocator.names("test/samples/module_names.rb")
          .must_equal ["Foo", "Foo::Bar", "Foo::Baz", "Foo::Qux", "Foo::Quux::Corge"]
      end
    end

    context "when a file is empty" do
      it "return an empty array" do
        Rubycritic::ModulesLocator.names("test/samples/empty.rb").must_equal []
      end
    end

    context "when a file is unparsable" do
      it "does not blow up" do
        capture_output_streams do
          Rubycritic::ModulesLocator.names("test/samples/unparsable.rb").must_equal []
        end
      end
    end
  end
end
