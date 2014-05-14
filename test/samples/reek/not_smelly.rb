class Perfume
  attr_reader :perfumed

  def ignoreRubyStyle(oneParameter)
    oneVariable = oneParameter
  end

  def allowNestingIteratorsTwoLevelsDeep
    loop do
      loop do
      end
    end
  end

  def method_with_too_many_statements
    do_something
    do_something
    do_something
    do_something
    do_something
    do_something
  end
end
