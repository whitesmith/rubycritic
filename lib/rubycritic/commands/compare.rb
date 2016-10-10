# frozen_string_literal: true
require 'rubycritic/source_control_systems/base'
require 'rubycritic/analysers_runner'
require 'rubycritic/revision_comparator'
require 'rubycritic/reporter'
require 'rubycritic/commands/base'
require 'rubycritic/commands/default'

module RubyCritic
  module Command
    class Compare < Default
      def initialize(options)
        super
        @build_number = 0
      end

      def execute
        compare_branches
        status_reporter.score = Config.feature_branch_score
        status_reporter
      end

      private

      attr_reader :paths, :status_reporter

      def compare_branches
        update_build_number
        set_root_paths
        Config.no_browser = true
        analyse_branch(:base_branch)
        analyse_branch(:feature_branch)
        Config.no_browser = false
        analyse_modified_files
        compare_code_quality
      end

      # keep track of the number of builds and
      # use this build number to create seperate directory for each build
      def update_build_number
        build_file_location = '/tmp/build_count.txt'
        File.new(build_file_location, 'a') unless File.exist?(build_file_location)
        @build_number = File.open(build_file_location).readlines.first.to_i + 1
        File.write(build_file_location, @build_number)
      end

      def set_root_paths
        Config.base_root_directory = Pathname.new(branch_directory(:base_branch))
        Config.feature_root_directory = Pathname.new(branch_directory(:feature_branch))
        Config.build_root_directory = Pathname.new(build_directory)
      end

      # switch branch and analyse files
      def analyse_branch(branch)
        SourceControlSystem::Git.switch_branch(Config.send(branch))
        critic = critique(branch)
        Config.send(:"#{branch}_score=", critic.score)
        Config.root = branch_directory(branch)
        report(critic)
      end

      # generate report only for modified files
      def analyse_modified_files
        modified_files = Config.feature_branch_collection.where(SourceControlSystem::Git.modified_files)
        analysed_modules = AnalysedModulesCollection.new(modified_files.map(&:path), modified_files)
        Config.root = build_directory
        report(analysed_modules)
      end

      def compare_code_quality
        build_details
        compare_threshold
      end

      # mark build as failed if the diff b/w the score of
      # two branches is greater than threshold value
      def compare_threshold
        return unless mark_build_fail?
        print("Threshold: #{Config.threshold_score}\n")
        print("Difference: #{(Config.base_branch_score - Config.feature_branch_score).abs}\n")
        abort('The score difference between the two branches is over the threshold.')
      end

      def mark_build_fail?
        Config.threshold_score > 0 && threshold_reached?
      end

      def threshold_reached?
        (Config.base_branch_score - Config.feature_branch_score) > Config.threshold_score
      end

      def branch_directory(branch)
        "tmp/rubycritic/compare/#{Config.send(branch)}"
      end

      def build_directory
        "tmp/rubycritic/compare/builds/build_#{@build_number}"
      end

      # create a txt file with the branch score details
      def build_details
        details = "Base branch (#{Config.base_branch}) score: #{Config.base_branch_score} \n"\
                  "Feature branch (#{Config.feature_branch}) score: #{Config.feature_branch_score} \n"
        File.open("#{Config.build_root_directory}/build_details.txt", 'w') { |file| file.write(details) }
      end

      # store the analysed moduled collection based on the branch
      def critique(branch)
        module_collection = AnalysersRunner.new(paths).run
        Config.send(:"#{branch}_collection=", module_collection)
        RevisionComparator.new(paths).set_statuses(module_collection)
      end
    end
  end
end
