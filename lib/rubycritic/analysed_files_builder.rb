require "rubycritic/core/analysed_file"

module Rubycritic

  class AnalysedFilesBuilder
    def initialize(pathnames, smells, churn, complexity)
      @pathnames = pathnames
      @smells = smells
      @churn = churn
      @complexity = complexity
    end

    def analysed_files
      @pathnames.zip(@churn, @complexity).map do |file_attributes|
        pathname = file_attributes[0]
        AnalysedFile.new(
          :smells => file_smells(pathname),
          :pathname => pathname,
          :churn => file_attributes[1],
          :complexity => file_attributes[2]
        )
      end
    end

    private

    def file_smells(pathname)
      file_smells = []
      @smells.each do |smell|
        file_smells << smell if smell.at_pathname?(pathname)
      end
      file_smells
    end
  end

end
