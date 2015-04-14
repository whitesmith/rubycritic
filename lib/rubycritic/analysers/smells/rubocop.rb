require "rubycritic/core/smell"
require "json"

module Rubycritic
  module Analyser

    class RuboCopSmells
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        result = JSON.parse(`rubocop --format json #{@analysed_modules.map(&:path).join(" ")}`)

        result["files"].each do |file_hash|
          next if file_hash["offenses"].empty?

          analysed_module = @analysed_modules.detect { |am| am.path == file_hash["path"] }
          next if analysed_module.nil?

          file_hash["offenses"].each do |offense|
            add_smells_to(analysed_module, offense)
          end
        end
      end

      private

      def add_smells_to(analysed_module, offense)
        analysed_module.smells << create_smell(analysed_module, offense)
      end

      def create_smell(analysed_module, offense)
        Smell.new(
          :locations => [Location.new(analysed_module.path, offense["location"]["line"])],
          :context   => offense["cop_name"],
          :message   => offense["message"],
          :type      => offense["cop_name"],
          :cost      => 0
        )
      end
    end

  end
end
