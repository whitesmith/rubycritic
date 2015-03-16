module Rubycritic
  module Generator
    class GlobalRatingCalculator
      def self.calculate_gpa(analysed_modules)
        gpa_sum = 0
        total_lines = 0
        analysed_modules.each do |analysed_module|
          gpa_sum += (analysed_module.rating.to_gpa) * analysed_module.lines
          total_lines += analysed_module.lines
        end
        gpa_sum / total_lines
      end
    end
  end
end
